sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'gateentry/test/integration/FirstJourney',
		'gateentry/test/integration/pages/GateEntryList',
		'gateentry/test/integration/pages/GateEntryObjectPage'
    ],
    function(JourneyRunner, opaJourney, GateEntryList, GateEntryObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('gateentry') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheGateEntryList: GateEntryList,
					onTheGateEntryObjectPage: GateEntryObjectPage
                }
            },
            opaJourney.run
        );
    }
);
sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'project1/test/integration/FirstJourney',
		'project1/test/integration/pages/EntryList',
		'project1/test/integration/pages/EntryObjectPage'
    ],
    function(JourneyRunner, opaJourney, EntryList, EntryObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('project1') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheEntryList: EntryList,
					onTheEntryObjectPage: EntryObjectPage
                }
            },
            opaJourney.run
        );
    }
);
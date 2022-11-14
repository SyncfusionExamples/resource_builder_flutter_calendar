# How to use resource builder in the Flutter Calendar (SfCalendar)?

This example demonstrates how to use resource builder in the Flutter Calendar.

## Setting up the resource view header builder

In the Flutter Calendar, you can add custom widgets for resources by using the [resourceHeaderBuilder](https://pub.dev/documentation/syncfusion_flutter_calendar/latest/calendar/ResourceViewHeaderBuilder.html) property of the calendar.

```

child: SfCalendar(
view: CalendarView.timelineWeek,
showDatePickerButton: true,
allowedViews: _allowedViews,
dataSource: _events,
resourceViewHeaderBuilder: resourceBuilder,
),

Widget resourceBuilder(
    BuildContext context, ResourceViewHeaderDetails details) {
  if (details.resource.image != null) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        CircleAvatar(backgroundImage:details.resource.image,backgroundColor: details.resource.color),
        Center(child: Text(details.resource.displayName,textAlign: TextAlign.center,)),
      ],
    );
  }
  else {
    return Container(
      color: details.resource.color,
      child: Text(details.resource.displayName),
    );
  }
}

```

You can also refer our UG documentation to know more about [ResourceViewBuilder](https://help.syncfusion.com/flutter/calendar/builders#resource-view-header-builder) in the Flutter Calendar.

## Requirements to run the demo
* [VS Code](https://code.visualstudio.com/download)
* [Flutter SDK v1.22+](https://flutter.dev/docs/development/tools/sdk/overview)
* [For more development tools](https://flutter.dev/docs/development/tools/devtools/overview)

## How to run this application
To run this application, you need to first clone or download the ‘create a flutter maps widget in 10 minutes’ repository and open it in your preferred IDE. Then, build and run your project to view the output.

## Further help
For more help, check the [Syncfusion Flutter documentation](https://help.syncfusion.com/flutter/introduction/overview),
 [Flutter documentation](https://flutter.dev/docs/get-started/install).

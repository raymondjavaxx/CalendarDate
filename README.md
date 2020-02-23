# CalendarDate

Calendar dates for Swift, built around [DateComponents](https://developer.apple.com/documentation/foundation/datecomponents). Provides value objects for representing dates and times that are not directly bound to specific UTC offsets or timezones. This is useful when [working with future events](http://www.creativedeletion.com/2015/03/19/persisting_future_datetimes.html), as in the case of event and appointment scheduling apps.

CalendarDate provides the following value types:

* `CalendarTime`: Represents a wall time, such as "2:00PM".
* `CalendarDate`: Represents a calendar date, such as a birthday.
* `CalendarDateTime`: Groups `CalendarDate` and `CalendarTime` to represent a date + time.

## How to use it

You can initialize a `CalendarDateTime` value directly and convert it to a Swift `Date` when you need to display it to the user.


```swift
let meetingDate = CalendarDateTime(year: 2020, month: 4, day: 1, hour: 10, minute: 30)
let meetingTimezone = TimeZone(identifier: "America/New_York")

let date = meetingDate.asDate(timezone: meetingTimezone!)

let formatter = DateFormatter()
formatter.dateStyle = .long
formatter.timeStyle = .long
formatter.timeZone = TimeZone(identifier: "America/New_York") // Or .current

formatter.string(from: date) // -> "April 1, 2020 at 10:30:00 AM EDT"
```

### Codable

The value types provided by this library all conform to [Codable](https://developer.apple.com/documentation/swift/codable).

| Value Type   | Codable format |
|---  |---  |
| `CalendarTime` | hh:mm:ss |
| `CalendarDate` | YYYY-MM-DD |
| `CalendarDateTime` | YYYY-MM-DDThh:mm:ss |


## Recommended reads

* [How to save datetimes for future events - (when UTC is not the right answer.)](http://www.creativedeletion.com/2015/03/19/persisting_future_datetimes.html)
* [Falsehoods programmers believe about time and time zones.](http://www.creativedeletion.com/2015/01/28/falsehoods-programmers-date-time-zones.html)
* [Time Zones Aren't Offsets – Offsets Aren't Time Zones.](https://spin.atomicobject.com/2016/07/06/time-zones-offsets/)
* [Working with Time Zones.](https://www.w3.org/TR/timezone/#history)

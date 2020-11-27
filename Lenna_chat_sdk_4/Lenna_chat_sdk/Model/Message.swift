//
//  Message.swift
//  Lenna
//
//  Created by MacBook Air on 4/30/19.
//  Copyright © 2019 sdtech. All rights reserved.
//

import Foundation

struct Chat : Decodable{
    let type : String!
    let date : String!
    let time : String!
    let outputText : [OutputText]!
    let outputImage : [OutputImage]!
    let outputCarousel : [OutputCarousel]!
}

struct OutputText : Decodable {
    let speech : String!
    let text : String!
    let type : String!
}

struct OutputHtml : Decodable {
    let type : String!
    let html : String!
}

struct OutputImage : Decodable{
    let originalContentUrl : String!
    let previewImageUrl : String!
    let type : String!
}

struct OutputCarousel : Decodable {
    let columns : [ColumnCarousel]!
    public var imageAspectRatio : String!
    public var imageSize : String!
    public var speech : String!
    public var text : String!
    public var type : String!}

struct ColumnCarousel : Decodable{
    let actions : [ActionCarousel]!
    let defaultAction : DefaultActionCarousel!
    public var imageBackgroundColor : String!
    public var text : String!
    public var thumbnailImageUrl : String!
    public var title : String!}

struct ActionCarousel : Decodable{
    let data : String!
    let label : String!
    let type : String!
    let uri : String!
}

struct DefaultActionCarousel : Decodable {
    let label : String!
    let type : String!
    let uri : String!
}

struct OutputList : Decodable {
    public var columns : [ColumnList]!
    public var title : String!
    public var type : String!
    public var imageUrl : String!
    public var subTitle : String!
}

struct ColumnList : Decodable {
    public var defaultAction : DefaultActionList!
    public var subText : String!
    public var text : String!
}

struct DefaultActionList : Decodable {
    public var data : String!
    public var label : String!
    public var type : String!
}

struct OutputMovieCarousel : Decodable{
    let columns : [ColumnMovieCarousel]!
    let imageAspectRatio : String!
    let imageSize : String!
    let type : String!
}

struct ColumnMovieCarousel : Decodable{
    let actions : [ActionMovie]!
    let defaultAction : DefaultActionMovie!
    let thumbnailImageUrl : String!
    let title : String!
}

struct ActionMovie : Decodable{
    let data : DataMovie!
    let label : String!
    let type : String!
}

struct DataMovie : Decodable {
    public var age : String!
    public var ageIconUrl : String!
    public var category : String!
    public var categoryIconUrl : String!
    public var director : String!
//    public var duration : Int!
    public var producer : String!
    public var production : String!
    public var rating : String!
    public var ratingIconUrl : String!
    public var showTimes : [String]!
    public var stars : String!
    public var synopsis : String!
    public var thumbnailUrl : String!
    public var title : String!
    public var trailerUrl : String!
    public var writer : String!
    
}

struct DefaultActionMovie : Decodable{
    let label : String!
    let type : String!
    let uri : String!
}

struct OutputConfirm : Decodable{
    public var actions : [ActionConfirm]!
    public var text : String!
    public var type : String!
}

struct ActionConfirm : Decodable {
    public var label : String!
    public var text : String!
    public var type : String!
}

struct OutputGrid : Decodable {
    public var columns : [ColumnGrid]!
    public var imageUrl : String!
    public var subTitle : String!
    public var title : String!
    public var type : String!
}

struct ColumnGrid : Decodable {
    public var defaultAction : DefaultActionGrid!
    public var subText : String!
    public var text : String!
}

struct DefaultActionGrid : Decodable {
    public var type : String!
    public var label : Int!
    public var data : Int!
}

struct OutputForm : Decodable {
    public var columns : [ColumnForm]!
    public var title : String!
    public var type : String!
}

struct ColumnForm : Decodable {
    public var id : String!
    public var label : String!
    public var name : String!
    public var required : Bool!
    public var subType : String!
    public var type : String!
}

struct OutputSummary : Decodable{
    public var columns : [ColumnSummary]!
    public var imageUrl : String!
    public var speech : String!
    public var text : String!
    public var title : String!
    public var type : String!
}

struct ColumnSummary : Decodable {
    public var field : String!
    public var value : String!
}

struct OutputAirplane : Decodable {
    public var columns : [ColumnAirplane]!
    public var type : String!
}

struct ColumnAirplane : Decodable {
    public var airline : String!
    public var airlineIconUrl : String!
    public var arriveTime : String!
    public var classGroupId : String!
    public var code : String!
    public var currencyCode : String!
    public var departTime : String!
    public var destination : String!
    public var destinationAirport : String!
    public var destinationCity : String!
    public var destinationCountry : String!
    public var flightNumber : String!
    public var flightType : String!
    public var itemId : String!
    public var origin : String!
    public var originAirport : String!
    public var originCity : String!
    public var originCountry : String!
    public var price : String!
    public var rawPrice : Int!
    public var scheduleMainId : String!
    public var shortArriveDate : String!
    public var shortArriveTime : String!
    public var shortDepartDate : String!
    public var shortDepartTime : String!
}

struct OutputAirplaneForm : Decodable {
    public var columns : [ColumnAirplaneForm]!
    public var title : String!
    public var type : String!
}

struct ColumnAirplaneForm : Decodable {
    public var departure : String!
    public var destination : String!
    public var masterAirport : [MasterAirport]!
    public var origin : String!
    public var paxAdult : [Int]!
    public var paxChild : [Int]!
    public var paxInfant : [Int]!
    public var returnField : String!
    public var tripType : String!
}

struct MasterAirport : Decodable {
    public var airportCode : String!
    public var location : String!
}

struct OutputTrainPassenger : Decodable {
    public var columns : ColumnTrainPassenger!
    public var title : String!
    public var type : String!
}

struct ColumnTrainPassenger : Decodable {
    public var contact : [ContactTrain]!
    public var passenger : [[PassengerTrain]]!
}

struct ContactTrain : Decodable {
    public var label : String!
    public var name : String!
}

struct PassengerTrain : Decodable {
    public var label : String!
    public var name : String!
}

struct OutputZakatFitrah : Decodable {
    public var columns : [ColumnZakatFitrah]!
    public var title : String!
    public var type : String!
}

struct ColumnZakatFitrah : Decodable {
    public var label : String!
    public var name : String!
}

struct OutputZakatProfesi : Decodable {
    public var columns : [ColumnZakatProfesi]!
    public var title : String!
    public var type : String!
}

struct ColumnZakatProfesi : Decodable {
    public var label : String!
    public var name : String!
}

struct OutputZakatMaal : Decodable {
    public var columns : [ColumnZakatMaal]!
    public var title : String!
    public var type : String!
}

struct ColumnZakatMaal : Decodable {
    public var label : String!
    public var name : String!
}

struct OutputFormDonasi : Decodable {
    public var columns : [ColumnDonasi]!
    public var title : String!
    public var type : String!
}

struct ColumnDonasi : Decodable {
    public var label : String!
    public var name : String!
}

struct OutputFormMuzaki : Decodable {
    public var columns : [ColumnMuzaki]!
    public var title : String!
    public var type : String!
}

struct ColumnMuzaki : Decodable {
    public var label : String!
    public var name : String!
}

struct OutputTrainTrip : Decodable {
    public var columns : [ColumnTrainTrip]!
    public var data : DataTrainTrip!
    public var title : String!
    public var type : String!
}

struct ColumnTrainTrip : Decodable {
    public var label : String!
    public var name : String!
}

struct DataTrainTrip : Decodable {
     public var stations : [Station]!
}

struct Station : Decodable {
    public var label : String!
    public var value : String!
}

struct OutputWeather : Decodable {
    public var area : String!
    public var columns : [ColumnWeather]!
    public var country : String!
    public var countryCode : String!
    public var type : String!
}

struct ColumnWeather : Decodable {
    public var date : String!
    public var dayIconUrl : String!
    public var dayWeather : String!
    public var longDate : String!
    public var maxTemperature : Int!
    public var minTemperature : Int!
    public var nightIconUrl : String!
    public var nightWeather : String!
    public var shortDate : String!
    public var temperature : Int!
}

struct OutputDetailMovie : Decodable {
    public var age : String!
    public var ageIconUrl : String!
    public var category : String!
    public var categoryIconUrl : String!
    public var defaultAction : String!
    public var rating : String!
    public var ratingIconUrl : String!
    public var showTimes : [String]!
    public var stars : String!
    public var synopsis : String!
    public var title : String!
    public var type : String!
}

struct OutputAction : Decodable {
    public var data : Data!
    public var subType : String!
    public var type : String!
}

struct DataComposeEmail : Decodable {
    public var cc : String!
    public var emailAddress : String!
    public var message : String!
    public var subject : String!
}

struct DataComposeCall : Decodable {
    public var phoneNumber : String!
}

struct DataComposeSMS : Decodable{
    public var message : String!
    public var recipient : String!
}

struct DataOpenApp : Decodable {
    public var packageName : String!
}

struct DataSchedule : Decodable {
    public var hours : String!
    public var minutes : String!
    public var alarmMessage : String!
}

struct DataReminder : Decodable {
    public var reminderTitle : String!
    public var reminderDate : String!
    public var reminderTime : String!
}

struct DataQuickButton : Decodable {
    public var quickbutton : [String]!
}

class Message {
    var messageText : String = ""
    var messageHtml = [OutputHtml]()
    var messageImage = [OutputImage]()
    var messageCarousel = [OutputCarousel]()
    var messageMovieCarousel = [OutputMovieCarousel]()
    var messageConfirm = [OutputConfirm]()
    var messageGrid = [OutputGrid]()
    var messageList = [OutputList]()
    var messageForm = [OutputForm]()
    var messageSummary = [OutputSummary]()
    var messageAirplane = [OutputAirplane]()
    var messageAirplaneForm = [OutputAirplaneForm]()
    var messageTrainTripForm = [OutputTrainTrip]()
    var messageTrainPassengerForm = [OutputTrainPassenger]()
    var messageZakatfitrah = [OutputZakatFitrah]()
    var messageZakatProfesi = [OutputZakatProfesi]()
    var messageZakatMaal = [OutputZakatMaal]()
    var messageFormMuzaki = [OutputFormMuzaki]()
    var messageFormDonasi = [OutputFormDonasi]()
    var messageWeather = [OutputWeather]()
    var messageDetailMovie = [OutputDetailMovie]()
    var messageAction = [OutputAction]()
    var messageComposeEmail : DataComposeEmail!
    var messageComposeSMS : DataComposeSMS!
    var messageComposeCall : DataComposeCall!
    var messageOpenApp : DataOpenApp!
    var messageSchedule : DataSchedule!
    var messageReminder : DataReminder!
    var originalContentUrl : String = ""
    var confirmHasShow = false
    var formHasShow = false
    var formTrainTrip = false
    var formTrainPassenger = false
    var formZakatFitrah = false
    var formZakatProfesi = false
    var formZakatMaal = false
    var formZakatDonasi = false
    var formZakatMuzaki = false
    var emailHasShow = false
    var smsHasShow = false
    var callHasShow = false
    var scheduleHasShow = false
    var reminderHasShow = false
    var openAppHasShow = false
    var formTravelHasShow = false
    var type : String = ""
    var subType : String = ""
    var time: String = ""
    var messageFromMe : String = ""
}

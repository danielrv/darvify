//
//  ee_darv_DarvifyTests.swift
//  ee.darv.DarvifyTests
//
//  Created by Dan on 22-12-22.
//

import XCTest

final class ee_darv_DarvifyTests: XCTestCase {

    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testObtenerImagen(){
        let serverComm = ServerComms()
        let exp = expectation(description: "Se debe obtener un dato y uiimage")
        serverComm.obtenerImagen(endpoint: "https://upload.wikimedia.org/wikipedia/commons/7/7d/IBM_PowerPC601_PPC601FD-080-2_top.jpg") { dato, err in
            XCTAssertNotNil(dato)
            XCTAssertNil(err)
            let image = UIImage(data: dato ?? Data())
            XCTAssertNotNil(image)
            exp.fulfill()
        }
        wait(for: [exp], timeout: 10)
    }
    func testJSONModelNewReleases() throws{
        let testJSON = """
                        {
                          "albums": {
                            "href": "https://api.spotify.com/v1/browse/new-releases?country=CL&locale=en-US%2Cen%3Bq%3D0.9&offset=0&limit=2",
                            "items": [
                              {
                                "album_type": "single",
                                "artists": [
                                  {
                                    "external_urls": {
                                      "spotify": "https://open.spotify.com/artist/5pughe5rcsOq3GF0utMOs5"
                                    },
                                    "href": "https://api.spotify.com/v1/artists/5pughe5rcsOq3GF0utMOs5",
                                    "id": "5pughe5rcsOq3GF0utMOs5",
                                    "name": "DrefQuila",
                                    "type": "artist",
                                    "uri": "spotify:artist:5pughe5rcsOq3GF0utMOs5"
                                  }
                                ],
                                "available_markets": [
                                  "AD",
                                  "AE",
                                  "AG",
                                  "AL",
                                  "AM",
                                  "AO",
                                  "AR",
                                  "AT",
                                  "AU",
                                  "AZ",
                                  "BA",
                                  "BB",
                                  "BD",
                                  "BE",
                                  "BF",
                                  "BG",
                                  "BH",
                                  "BI",
                                  "BJ",
                                  "BN",
                                  "BO",
                                  "BR",
                                  "BS",
                                  "BT",
                                  "BW",
                                  "BZ",
                                  "CA",
                                  "CD",
                                  "CG",
                                  "CH",
                                  "CI",
                                  "CL",
                                  "CM",
                                  "CO",
                                  "CR",
                                  "CV",
                                  "CW",
                                  "CY",
                                  "CZ",
                                  "DE",
                                  "DJ",
                                  "DK",
                                  "DM",
                                  "DO",
                                  "DZ",
                                  "EC",
                                  "EE",
                                  "EG",
                                  "ES",
                                  "ET",
                                  "FI",
                                  "FJ",
                                  "FM",
                                  "FR",
                                  "GA",
                                  "GB",
                                  "GD",
                                  "GE",
                                  "GH",
                                  "GM",
                                  "GN",
                                  "GQ",
                                  "GR",
                                  "GT",
                                  "GW",
                                  "GY",
                                  "HK",
                                  "HN",
                                  "HR",
                                  "HT",
                                  "HU",
                                  "ID",
                                  "IE",
                                  "IL",
                                  "IN",
                                  "IQ",
                                  "IS",
                                  "IT",
                                  "JM",
                                  "JO",
                                  "JP",
                                  "KE",
                                  "KG",
                                  "KH",
                                  "KI",
                                  "KM",
                                  "KN",
                                  "KR",
                                  "KW",
                                  "KZ",
                                  "LA",
                                  "LB",
                                  "LC",
                                  "LI",
                                  "LK",
                                  "LR",
                                  "LS",
                                  "LT",
                                  "LU",
                                  "LV",
                                  "LY",
                                  "MA",
                                  "MC",
                                  "MD",
                                  "ME",
                                  "MG",
                                  "MH",
                                  "MK",
                                  "ML",
                                  "MN",
                                  "MO",
                                  "MR",
                                  "MT",
                                  "MU",
                                  "MV",
                                  "MW",
                                  "MX",
                                  "MY",
                                  "MZ",
                                  "NA",
                                  "NE",
                                  "NG",
                                  "NI",
                                  "NL",
                                  "NO",
                                  "NP",
                                  "NR",
                                  "NZ",
                                  "OM",
                                  "PA",
                                  "PE",
                                  "PG",
                                  "PH",
                                  "PK",
                                  "PL",
                                  "PS",
                                  "PT",
                                  "PW",
                                  "PY",
                                  "QA",
                                  "RO",
                                  "RS",
                                  "RW",
                                  "SA",
                                  "SB",
                                  "SC",
                                  "SE",
                                  "SG",
                                  "SI",
                                  "SK",
                                  "SL",
                                  "SM",
                                  "SN",
                                  "SR",
                                  "ST",
                                  "SV",
                                  "SZ",
                                  "TD",
                                  "TG",
                                  "TH",
                                  "TJ",
                                  "TL",
                                  "TN",
                                  "TO",
                                  "TR",
                                  "TT",
                                  "TV",
                                  "TW",
                                  "TZ",
                                  "UA",
                                  "UG",
                                  "US",
                                  "UY",
                                  "UZ",
                                  "VC",
                                  "VE",
                                  "VN",
                                  "VU",
                                  "WS",
                                  "XK",
                                  "ZA",
                                  "ZM",
                                  "ZW"
                                ],
                                "external_urls": {
                                  "spotify": "https://open.spotify.com/album/3VhjWwBpzemDHcytRUP5t9"
                                },
                                "href": "https://api.spotify.com/v1/albums/3VhjWwBpzemDHcytRUP5t9",
                                "id": "3VhjWwBpzemDHcytRUP5t9",
                                "images": [
                                  {
                                    "height": 640,
                                    "url": "https://i.scdn.co/image/ab67616d0000b27349071624cb70e823243adf53",
                                    "width": 640
                                  },
                                  {
                                    "height": 300,
                                    "url": "https://i.scdn.co/image/ab67616d00001e0249071624cb70e823243adf53",
                                    "width": 300
                                  },
                                  {
                                    "height": 64,
                                    "url": "https://i.scdn.co/image/ab67616d0000485149071624cb70e823243adf53",
                                    "width": 64
                                  }
                                ],
                                "name": "Diablo Santo",
                                "release_date": "2022-12-15",
                                "release_date_precision": "day",
                                "total_tracks": 6,
                                "type": "album",
                                "uri": "spotify:album:3VhjWwBpzemDHcytRUP5t9"
                              },
                              {
                                "album_type": "single",
                                "artists": [
                                  {
                                    "external_urls": {
                                      "spotify": "https://open.spotify.com/artist/7ltDVBr6mKbRvohxheJ9h1"
                                    },
                                    "href": "https://api.spotify.com/v1/artists/7ltDVBr6mKbRvohxheJ9h1",
                                    "id": "7ltDVBr6mKbRvohxheJ9h1",
                                    "name": "ROSALÍA",
                                    "type": "artist",
                                    "uri": "spotify:artist:7ltDVBr6mKbRvohxheJ9h1"
                                  },
                                  {
                                    "external_urls": {
                                      "spotify": "https://open.spotify.com/artist/4kYSro6naA4h99UJvo89HB"
                                    },
                                    "href": "https://api.spotify.com/v1/artists/4kYSro6naA4h99UJvo89HB",
                                    "id": "4kYSro6naA4h99UJvo89HB",
                                    "name": "Cardi B",
                                    "type": "artist",
                                    "uri": "spotify:artist:4kYSro6naA4h99UJvo89HB"
                                  }
                                ],
                                "available_markets": [
                                  "AD",
                                  "AE",
                                  "AG",
                                  "AL",
                                  "AM",
                                  "AO",
                                  "AR",
                                  "AT",
                                  "AU",
                                  "AZ",
                                  "BA",
                                  "BB",
                                  "BD",
                                  "BE",
                                  "BF",
                                  "BG",
                                  "BH",
                                  "BI",
                                  "BJ",
                                  "BN",
                                  "BO",
                                  "BR",
                                  "BS",
                                  "BT",
                                  "BW",
                                  "BY",
                                  "BZ",
                                  "CA",
                                  "CD",
                                  "CG",
                                  "CH",
                                  "CI",
                                  "CL",
                                  "CM",
                                  "CO",
                                  "CR",
                                  "CV",
                                  "CW",
                                  "CY",
                                  "CZ",
                                  "DE",
                                  "DJ",
                                  "DK",
                                  "DM",
                                  "DO",
                                  "DZ",
                                  "EC",
                                  "EE",
                                  "EG",
                                  "ES",
                                  "ET",
                                  "FI",
                                  "FJ",
                                  "FM",
                                  "FR",
                                  "GA",
                                  "GB",
                                  "GD",
                                  "GE",
                                  "GH",
                                  "GM",
                                  "GN",
                                  "GQ",
                                  "GR",
                                  "GT",
                                  "GW",
                                  "GY",
                                  "HK",
                                  "HN",
                                  "HR",
                                  "HT",
                                  "HU",
                                  "ID",
                                  "IE",
                                  "IL",
                                  "IN",
                                  "IQ",
                                  "IS",
                                  "IT",
                                  "JM",
                                  "JO",
                                  "JP",
                                  "KE",
                                  "KG",
                                  "KH",
                                  "KI",
                                  "KM",
                                  "KN",
                                  "KR",
                                  "KW",
                                  "KZ",
                                  "LA",
                                  "LB",
                                  "LC",
                                  "LI",
                                  "LK",
                                  "LR",
                                  "LS",
                                  "LT",
                                  "LU",
                                  "LV",
                                  "LY",
                                  "MA",
                                  "MC",
                                  "MD",
                                  "ME",
                                  "MG",
                                  "MH",
                                  "MK",
                                  "ML",
                                  "MN",
                                  "MO",
                                  "MR",
                                  "MT",
                                  "MU",
                                  "MV",
                                  "MW",
                                  "MX",
                                  "MY",
                                  "MZ",
                                  "NA",
                                  "NE",
                                  "NG",
                                  "NI",
                                  "NL",
                                  "NO",
                                  "NP",
                                  "NR",
                                  "NZ",
                                  "OM",
                                  "PA",
                                  "PE",
                                  "PG",
                                  "PH",
                                  "PK",
                                  "PL",
                                  "PS",
                                  "PT",
                                  "PW",
                                  "PY",
                                  "QA",
                                  "RO",
                                  "RS",
                                  "RW",
                                  "SA",
                                  "SB",
                                  "SC",
                                  "SE",
                                  "SG",
                                  "SI",
                                  "SK",
                                  "SL",
                                  "SM",
                                  "SN",
                                  "SR",
                                  "ST",
                                  "SV",
                                  "SZ",
                                  "TD",
                                  "TG",
                                  "TH",
                                  "TJ",
                                  "TL",
                                  "TN",
                                  "TO",
                                  "TR",
                                  "TT",
                                  "TV",
                                  "TW",
                                  "TZ",
                                  "UA",
                                  "UG",
                                  "US",
                                  "UY",
                                  "UZ",
                                  "VC",
                                  "VE",
                                  "VN",
                                  "VU",
                                  "WS",
                                  "XK",
                                  "ZA",
                                  "ZM",
                                  "ZW"
                                ],
                                "external_urls": {
                                  "spotify": "https://open.spotify.com/album/4czxiqSwyeZK7y5r9GNWXP"
                                },
                                "href": "https://api.spotify.com/v1/albums/4czxiqSwyeZK7y5r9GNWXP",
                                "id": "4czxiqSwyeZK7y5r9GNWXP",
                                "images": [
                                  {
                                    "height": 640,
                                    "url": "https://i.scdn.co/image/ab67616d0000b273004be8772c8f598c58d71f72",
                                    "width": 640
                                  },
                                  {
                                    "height": 300,
                                    "url": "https://i.scdn.co/image/ab67616d00001e02004be8772c8f598c58d71f72",
                                    "width": 300
                                  },
                                  {
                                    "height": 64,
                                    "url": "https://i.scdn.co/image/ab67616d00004851004be8772c8f598c58d71f72",
                                    "width": 64
                                  }
                                ],
                                "name": "DESPECHÁ RMX",
                                "release_date": "2022-12-16",
                                "release_date_precision": "day",
                                "total_tracks": 1,
                                "type": "album",
                                "uri": "spotify:album:4czxiqSwyeZK7y5r9GNWXP"
                              }
                            ],
                            "limit": 2,
                            "next": "https://api.spotify.com/v1/browse/new-releases?country=CL&locale=en-US%2Cen%3Bq%3D0.9&offset=2&limit=2",
                            "offset": 0,
                            "previous": null,
                            "total": 100
                          }
                        }
                        """
        let data = testJSON.data(using: .utf8) ?? Data()
        let newReleases = try JSONDecoder().decode(NewReleases.self, from: data)
        XCTAssertNotNil(newReleases)
        let numeroReleases = newReleases.albums.items.count
        XCTAssert(numeroReleases == 2)
    }
    
    func testOauthUtils() throws{
        let slp = SpotifyLoginProvider()
        let codeVerifier = slp.createCodeVerifier()
        XCTAssertNotNil(codeVerifier)
        let challange = slp.codeChallenge(for: codeVerifier)
        XCTAssertNotNil(challange)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}

//
//  LogInView.swift
//  ios-livestreamer-innercircle
//
//  Created by Mikaela Caron on 1/25/24.
//

import StreamVideo
import SwiftUI

private enum FocusableField: Hashable {
    case username
    case email
    case password
}

struct UserCredentials: Identifiable {
    let id: String
    let name: String
    let imageURL: URL
    let token: UserToken
    let birthLand: String
    
    var user: User {
        .init(id: id, name: name, imageURL: imageURL)
    }
}

struct LoginListView: View {
    @Environment(AuthenticationViewModel.self) var authenticationViewModel
    
    
    var body: some View {
        Text("h")
    }
}

struct LogInView: View {
    
    @Environment(AuthenticationViewModel.self) var authenticationViewModel
    
    @FocusState private var focus: FocusableField?
    
    var body: some View {
        @Bindable var authenticationViewModel = authenticationViewModel
        
        NavigationStack {
            List(UserCredentials.builtInUsers) { user in
                HStack {
                    AsyncImage(url: user.imageURL) { image in
                        image.image?.resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40, height: 40)
                    }
                    
                    Text(user.name)
                }
                .onTapGesture {
                    authenticationViewModel.user = user
                    authenticationViewModel.authenticationState = .authenticated
                }
            }
            .navigationTitle(Text("Log In to Inner Circle"))
        }
    }
    
    private func signInWithEmailPassword() {
        Task {
            await authenticationViewModel.signInWithEmailPassword()
        }
    }
}

#Preview {
    LogInView()
}



extension UserCredentials {
    static let builtInUsers: [UserCredentials] = [
        .luke,
        .leia,
        .hanSolo,
        .lando,
        .chewbacca,
        .c3po,
        .r2d2,
        .anakin,
        .obiwan,
        .padme,
        .quiGonJinn,
        .maceWindu,
        .jarJarBinks,
        .darthMaul,
        .countDooku,
        .generalGrievous
    ]

    static func builtInUsersByID(id: String) -> UserCredentials? {
        builtInUsers.first { $0.id == id }
    }

    static let luke = Self(
        id: "luke_skywalker",
        name: "Luke Skywalker",
        imageURL: URL(string: "https://vignette.wikia.nocookie.net/starwars/images/2/20/LukeTLJ.jpg")!,
        token: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoibHVrZV9za3l3YWxrZXIifQ.kFSLHRB5X62t0Zlc7nwczWUfsQMwfkpylC6jCUZ6Mc0",
        birthLand: "Tatooine"
    )

    static let leia = Self(
        id: "leia_organa",
        name: "Leia Organa",
        imageURL: URL(string: "https://vignette.wikia.nocookie.net/starwars/images/f/fc/Leia_Organa_TLJ.png")!,
        token: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoibGVpYV9vcmdhbmEifQ.IzwBuaYwX5dRvnDDnJN2AyW3wwfYwgQm3w-1RD4BLPU",
        birthLand: "Polis Massa"
    )

    static let hanSolo = Self(
        id: "han_solo",
        name: "Han Solo",
        imageURL: URL(string: "https://vignette.wikia.nocookie.net/starwars/images/e/e2/TFAHanSolo.png")!,
        token: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiaGFuX3NvbG8ifQ.R6PkQeGPcusALmhvaST50lwroL_JkZnI3Q7hQ1Hvj3k",
        birthLand: "Corellia"
    )

    static let lando = Self(
        id: "lando_calrissian",
        name: "Lando Calrissian",
        imageURL: URL(string: "https://vignette.wikia.nocookie.net/starwars/images/8/8f/Lando_ROTJ.png")!,
        token: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoibGFuZG9fY2Fscmlzc2lhbiJ9.n_K7d-FroQzBUxETNcEQYqiW_U9CPjRHZHT1hyAjlAQ",
        birthLand: "Socorro"
    )

    static let chewbacca = Self(
        id: "chewbacca",
        name: "Chewbacca",
        imageURL: URL(string: "https://vignette.wikia.nocookie.net/starwars/images/4/48/Chewbacca_TLJ.png")!,
        token: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiY2hld2JhY2NhIn0.4nNFfO0dehvdLxDUGaMQPpMliSTGjHqh1C2Zo8wyaeM",
        birthLand: "Kashyyyk"
    )

    static let c3po = Self(
        id: "c-3po",
        name: "C-3PO",
        imageURL: URL(string: "https://vignette.wikia.nocookie.net/starwars/images/3/3f/C-3PO_TLJ_Card_Trader_Award_Card.png")!,
        token: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiYy0zcG8ifQ.J4Xzu8rKP1XWQvSNV6wzWKW403qKd5N3FalpWXTDauw",
        birthLand: "Affa"
    )

    static let r2d2 = Self(
        id: "r2-d2",
        name: "R2-D2",
        imageURL: URL(string: "https://vignette.wikia.nocookie.net/starwars/images/e/eb/ArtooTFA2-Fathead.png")!,
        token: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoicjItZDIifQ.UpSEW8jA2tYsUTPKbdFGMtHHnu9_AnEQqTK6TdT8L1g",
        birthLand: "Naboo"
    )

    static let anakin = Self(
        id: "anakin_skywalker",
        name: "Anakin Skywalker",
        imageURL: URL(string: "https://vignette.wikia.nocookie.net/starwars/images/6/6f/Anakin_Skywalker_RotS.png")!,
        token: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiYW5ha2luX3NreXdhbGtlciJ9.oJkwakjdqw6gCA3-kaUaKqSVEcWO5ob5DJuyJCtnT6U",
        birthLand: "Tatooine"
    )

    static let obiwan = Self(
        id: "obi-wan_kenobi",
        name: "Obi-Wan Kenobi",
        imageURL: URL(string: "https://vignette.wikia.nocookie.net/starwars/images/4/4e/ObiWanHS-SWE.jpg")!,
        token: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoib2JpLXdhbl9rZW5vYmkifQ.AVOtnXtMq9crXFwl68BrBRob335phYpYfPPq5i2agUM",
        birthLand: "Stewjon"
    )

    static let padme = Self(
        id: "padme_amidala",
        name: "Padmé Amidala",
        imageURL: URL(string: "https://vignette.wikia.nocookie.net/starwars/images/b/b2/Padmegreenscrshot.jpg")!,
        token: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoicGFkbWVfYW1pZGFsYSJ9.X8CwsnrWKvdrS6XchcUMZDLh_W0X4Gpx-oNyjGAdenI",
        birthLand: "Naboo"
    )

    static let quiGonJinn = Self(
        id: "qui-gon_jinn",
        name: "Qui-Gon Jinn",
        imageURL: URL(string: "https://vignette.wikia.nocookie.net/starwars/images/f/f6/Qui-Gon_Jinn_Headshot_TPM.jpg")!,
        token: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoicXVpLWdvbl9qaW5uIn0.EDuyuTkyzG1OA3ROwa3sK8-K_U2MGREsY4Ic7flXvzw",
        birthLand: "Coruscant"
    )

    static let maceWindu = Self(
        id: "mace_windu",
        name: "Mace Windu",
        imageURL: URL(string: "https://vignette.wikia.nocookie.net/starwars/images/5/58/Mace_ROTS.png")!,
        token: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoibWFjZV93aW5kdSJ9.x8xFcOQFr0XUDeA3BH0ISsR2VSmWSxmMgbnz8lprV58",
        birthLand: "Haruun Kal"
    )

    static let jarJarBinks = Self(
        id: "jar_jar_binks",
        name: "Jar Jar Binks",
        imageURL: URL(string: "https://vignette.wikia.nocookie.net/starwars/images/d/d2/Jar_Jar_aotc.jpg")!,
        token: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiamFyX2phcl9iaW5rcyJ9.5-GhGE8sqlxKNUMyBGovrkoaxgkEQAUMJ3CZfcxyrZg",
        birthLand: "Naboo"
    )

    static let darthMaul = Self(
        id: "darth_maul",
        name: "Darth Maul",
        imageURL: URL(string: "https://vignette.wikia.nocookie.net/starwars/images/5/50/Darth_Maul_profile.png")!,
        token: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiZGFydGhfbWF1bCJ9._cbBA2ThWpXcyxwvBV6gvqAwnw0lvzfHAlZ4stGqf2o",
        birthLand: "Dathomir"
    )

    static let countDooku = Self(
        id: "count_dooku",
        name: "Count Dooku",
        imageURL: URL(string: "https://vignette.wikia.nocookie.net/starwars/images/b/b8/Dooku_Headshot.jpg")!,
        token: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiY291bnRfZG9va3UifQ.0sN_cPTKrXsxC23WUSIBUQK5IUZsdGijmqY50HJERQw",
        birthLand: "Serenno"
    )

    static let generalGrievous = Self(
        id: "general_grievous",
        name: "General Grievous",
        imageURL: URL(string: "https://vignette.wikia.nocookie.net/starwars/images/d/de/Grievoushead.jpg")!,
        token: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiZ2VuZXJhbF9ncmlldm91cyJ9.FPRvRoeZdALErBA1bDybch4xY-c5CEinuc9qqEPzX4E",
        birthLand: "Qymaen jai Sheelal"
    )
}

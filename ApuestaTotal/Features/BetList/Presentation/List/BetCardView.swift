//
//  BetCardView.swift
//  ApuestaTotal
//
//  Created by Deiby Toralva on 18/10/24.
//

import SwiftUI

struct BetCardView: View {
    
    @State private var isExpanded: Bool = false
    @State private var counter: Int = 0
    
    let data: BetViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(data.date)
                    .font(AppFonts.regular(size: 12))
                    .foregroundColor(AppColors.secondary)
                
                Spacer()
                
                Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 12, height: 12)
                    .foregroundColor(AppColors.secondary)
            }
            
            HStack(alignment: .top) {
                
                // Tipo de apuesta
                tag(title: data.typeTitle,
                    background: AppColors.secondary.opacity(0.2),
                    foregroundColor: AppColors.text)
                
                // Estado de la apuesta
                if data.status == .won || data.status == .cashout {
                    tag(title: "\(data.status.title)  \(data.level.icon)",
                        background: data.status.color,
                        foregroundColor: .white.opacity(0.8))
                } else {
                    tag(title: "\(data.status.title)",
                        background: data.status.color,
                        foregroundColor: .white.opacity(0.8))
                }
                
            }
            
            VStack(alignment: .leading, spacing: 4, content: {
                Text(data.title)
                    .lineLimit(isExpanded ? nil : 2)
                    .font(AppFonts.bold(size: 16))
                    .foregroundColor(AppColors.text)
                
                if let event = data.event {
                    Text(event)
                        .font(AppFonts.regular(size: 14))
                        .foregroundColor(AppColors.secondary)
                }
            })
            
            HStack {
                amount(title: "Apuesta", value: data.amount)
                
                Spacer()
                
                amount(title: "Cuotas", value: data.odd)
                
                Spacer()
                
                if let payment = data.payment {
                    amount(title: "Pago", value: payment, isBold: true)
                        .frame(width: 90)
                } else {
                    Spacer()
                        .frame(width: 90)
                }
            }
            .confettiCannon(counter: $counter, confettis: data.level.confettis, confettiSize: 25, repetitions: 2, repetitionInterval: 0.5)
            
            if isExpanded {
                Divider()
                
                if data.type == .simple {
                    if let selection = data.detail.selections.first {
                        Text("Resultado:")
                            .font(AppFonts.bold(size: 14))
                            .foregroundColor(AppColors.text)
                            .padding(.top, 4)
                        
                        switch selection.sportType {
                        case .soccer, .basquetball, .esport:
                            if let results = selection.results {
                                VStack {
                                    HStack {
                                        Text(results.team1Name)
                                            .font(AppFonts.regular(size: 16))
                                            .foregroundColor(AppColors.text)
                                        Spacer()
                                        Text(results.team1Score)
                                            .font(AppFonts.bold(size: 16))
                                            .foregroundColor(AppColors.text)
                                    }
                                    HStack {
                                        Text(results.team2Name)
                                            .font(AppFonts.regular(size: 16))
                                            .foregroundColor(AppColors.text)
                                        Spacer()
                                        Text(results.team2Score)
                                            .font(AppFonts.bold(size: 16))
                                            .foregroundColor(AppColors.text)
                                    }
                                }
                            }
                        case .boxeo:
                            EmptyView()
                        }
                        
                    }
                }
                
                if data.type == .multiple {
                    Text("Resultados:")
                        .font(AppFonts.bold(size: 14))
                        .foregroundColor(AppColors.text)
                        .padding(.top, 8)
                    
                    ForEach(data.detail.selections, id: \.id) { subBet in
                        
                        VStack(alignment: .leading, spacing: 4, content: {
                            Text(subBet.title)
                                .lineLimit(isExpanded ? nil : 2)
                                .font(AppFonts.bold(size: 16))
                                .foregroundColor(AppColors.text)
                            
                            Text(subBet.eventName)
                                .font(AppFonts.regular(size: 14))
                                .foregroundColor(.gray)
                                .foregroundColor(AppColors.secondary)
                            
                            if let results = subBet.results {
                                VStack {
                                    HStack {
                                        Text(results.team1Name)
                                            .font(AppFonts.regular(size: 16))
                                            .foregroundColor(AppColors.text)
                                        Spacer()
                                        Text(results.team1Score)
                                            .font(AppFonts.bold(size: 16))
                                            .foregroundColor(AppColors.text)
                                    }
                                    HStack {
                                        Text(results.team2Name)
                                            .font(AppFonts.regular(size: 16))
                                            .foregroundColor(AppColors.text)
                                        Spacer()
                                        Text(results.team2Score)
                                            .font(AppFonts.bold(size: 16))
                                            .foregroundColor(AppColors.text)
                                    }
                                }
                            }
                            
                            if data.detail.selections.last?.id != subBet.id {
                                Divider()
                                    .padding(.top, 10)
                            }
                        })
                    }
                }
            }
        }
        .padding()
        .background(AppColors.cardBackground)
        .cornerRadius(8)
        .shadow(color: AppColors.cardShadow.opacity(0.2), radius: 4 , x: 1, y: 2)
        .onTapGesture {
            withAnimation {
                isExpanded.toggle()
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                withAnimation {
                    counter += 1
                }
            })
        }
    }
    
    func tag(title: String, icon: String? = nil, background: Color, foregroundColor: Color) -> some View {
        HStack {
            Text(title)
                .font(AppFonts.bold(size: 12))
                .padding(.leading, 8)
                .padding(.trailing, icon != nil ? 0 : 8)
                .padding(.vertical, 4)
                .foregroundColor(foregroundColor)
            
            if let icon = icon {
                Image(systemName: icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 14, height: 14)
                    .foregroundColor(.white.opacity(0.8))
                    .padding(.trailing, 8)
            }
        }
        .background(background)
        .cornerRadius(4)
    }
    
    func amount(title: String, value: String, isBold: Bool = false) -> some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(title)
                .font(AppFonts.regular(size: 12))
                .foregroundColor(AppColors.secondary)
            Text(value)
                .font(isBold ? AppFonts.bold(size: 16) : AppFonts.regular(size: 16))
                .foregroundColor(isBold ? data.status.color : AppColors.text)
        }
    }
}

extension BetLevel {
    var confettis: [ConfettiType] {
        switch self {
        case .leyenda:
            return [.text("💵")]
        case .king:
            return [.text("👑")]
        case .master:
            return [.text("🏅")]
        case .capo:
            return [.text("💪")]
        case .cazafijas:
            return [.text("📝")]
        case .donatelo:
            return [.text("")]
        }
    }
}

// Vista de Previsualización
struct BetCardView_Previews: PreviewProvider {
    static var previews: some View {
        BetCardView(data: BetViewModel(
            bet: Bet(
                db: 1,
                operation: 987654,
                game: "Manchester United vs. Chelsea",
                createdDate: "2024-10-18 14:30:00",
                status: .won,
                wager: 50.0,
                winning: 150.0,
                odds: 3.0,
                type: .multiple,
                account: .cash
            ),
            detail: BetDetail(
                id: 1,
                nivel: .king,
                starts: 0,
                statusName: "Ganada",
                typeName: "Multiple",
                backgroundSource: nil,
                cashoutOdds: "0.00",
                totalOdds: "3.00",
                totalStake: "50.00",
                totalWin: "150.00",
                cashoutValue: nil,
                createdDate: "2024-10-18 14:30:00",
                selections: [
                    BetSelection(
                        selectionId: 1001,
                        status: 1,
                        price: "1.50",
                        name: "Ganador del Partido: Manchester United",
                        spec: nil,
                        marketTypeId: 1,
                        marketId: 101,
                        marketName: "Resultado",
                        isLive: false,
                        isBetBuilder: false,
                        isBanker: false,
                        isVirtual: false,
                        bbSelections: nil,
                        eventId: 12345,
                        eventName: "Manchester United vs. Chelsea",
                        sportType: .soccer,
                        eventScore: "2:1",
                        categoryName: "Premier League",
                        champName: "Premier League 2024"
                    ),
                    BetSelection(
                        selectionId: 1002,
                        status: 1,
                        price: "1.20",
                        name: "Total de goles: Más de 2.5",
                        spec: nil,
                        marketTypeId: 2,
                        marketId: 102,
                        marketName: "Goles",
                        isLive: false,
                        isBetBuilder: true,
                        isBanker: false,
                        isVirtual: false,
                        bbSelections: nil,
                        eventId: 12345,
                        eventName: "Sporting Cristal vs. Universitario",
                        sportType: .soccer,
                        eventScore: "2:1",
                        categoryName: "Premier League",
                        champName: "Premier League 2024"
                    )
                ],
                status: 1,
                type: 0
            )
        ))
        .previewLayout(.sizeThatFits)
        .padding()
    }
}

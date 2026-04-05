import SwiftUI

// MARK: - Role Panel View

struct RolePanelView: View {
    @ObservedObject var viewModel: GameViewModel

    var body: some View {
        VStack(spacing: 0) {
            // Panel header
            HStack {
                Image(systemName: "star.fill")
                    .font(.system(size: 12))
                    .foregroundColor(Color(red: 0.75, green: 0.5, blue: 0.1))
                Text("成立役")
                    .font(.system(size: 14, weight: .semibold, design: .rounded))
                    .foregroundColor(Color(red: 0.3, green: 0.12, blue: 0.02))
                Spacer()
                if !viewModel.completedRoles.isEmpty {
                    Text("合計 \(viewModel.totalScore)点")
                        .font(.system(size: 13, weight: .bold, design: .rounded))
                        .foregroundColor(Color(red: 0.7, green: 0.2, blue: 0.05))
                }
            }
            .padding(.horizontal, 14)
            .padding(.vertical, 8)
            .background(Color(red: 0.88, green: 0.82, blue: 0.72))

            Divider()
                .background(Color(red: 0.75, green: 0.65, blue: 0.5))

            if viewModel.completedRoles.isEmpty {
                EmptyRoleView()
            } else {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        ForEach(viewModel.completedRoles) { role in
                            RoleChipView(
                                role: role,
                                points: viewModel.points(for: role)
                            )
                        }
                    }
                    .padding(.horizontal, 14)
                    .padding(.vertical, 10)
                }
            }
        }
        .background(Color(red: 0.94, green: 0.89, blue: 0.80))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .strokeBorder(Color(red: 0.75, green: 0.6, blue: 0.4), lineWidth: 1)
        )
        .shadow(color: Color.black.opacity(0.08), radius: 4, x: 0, y: 2)
    }
}

// MARK: - Empty Role View

struct EmptyRoleView: View {
    var body: some View {
        HStack {
            Spacer()
            VStack(spacing: 4) {
                Text("🀇")
                    .font(.system(size: 24))
                Text("札をタップして役を確認")
                    .font(.system(size: 12))
                    .foregroundColor(Color(.systemGray2))
            }
            .padding(.vertical, 16)
            Spacer()
        }
    }
}

// MARK: - Role Chip View

struct RoleChipView: View {
    let role: KoiKoiRole
    let points: Int

    var body: some View {
        VStack(spacing: 3) {
            Text(role.name)
                .font(.system(size: 15, weight: .bold, design: .rounded))
                .foregroundColor(Color(red: 0.3, green: 0.08, blue: 0.02))

            Text(role.nameRomaji)
                .font(.system(size: 9, weight: .medium))
                .foregroundColor(Color(.systemGray2))

            Text("\(points)点")
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(.white)
                .padding(.horizontal, 8)
                .padding(.vertical, 2)
                .background(
                    Capsule()
                        .fill(Color(red: 0.65, green: 0.18, blue: 0.05))
                )
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(red: 1.0, green: 0.97, blue: 0.90))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .strokeBorder(Color(red: 0.8, green: 0.55, blue: 0.2), lineWidth: 1.5)
        )
    }
}

// MARK: - Preview

#Preview {
    let vm = GameViewModel()
    // Trigger some completed roles for preview
    return RolePanelView(viewModel: vm)
        .padding()
        .background(Color(red: 0.96, green: 0.93, blue: 0.87))
}

import SwiftUI

// MARK: - Content View

struct ContentView: View {
    @StateObject private var viewModel = GameViewModel()
    @State private var showRoleGuide = false

    var body: some View {
        ZStack {
            // Background
            Color(red: 0.96, green: 0.93, blue: 0.87)
                .ignoresSafeArea()

            VStack(spacing: 0) {
                // App Header
                headerView
                    .padding(.horizontal, 16)
                    .padding(.top, 8)
                    .padding(.bottom, 10)

                // Month Tab Bar
                MonthTabBar(viewModel: viewModel)
                    .padding(.bottom, 10)

                Divider()
                    .background(Color(red: 0.8, green: 0.7, blue: 0.55))
                    .padding(.horizontal, 12)
                    .padding(.bottom, 10)

                // Card Grid for selected month
                MonthCardGrid(viewModel: viewModel)
                    .padding(.bottom, 10)

                Spacer(minLength: 8)

                // Role Panel
                RolePanelView(viewModel: viewModel)
                    .padding(.horizontal, 12)
                    .padding(.bottom, 12)
            }
        }
        .sheet(isPresented: $showRoleGuide) {
            RoleGuideSheet()
        }
    }

    // MARK: Header

    private var headerView: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading, spacing: 2) {
                Text("花札役ガイド")
                    .font(.system(size: 22, weight: .bold, design: .rounded))
                    .foregroundColor(Color(red: 0.35, green: 0.1, blue: 0.02))
                Text("こいこい — 取った札をタップ")
                    .font(.system(size: 11))
                    .foregroundColor(Color(.systemGray2))
            }

            Spacer()

            HStack(spacing: 10) {
                // Selected count badge
                if viewModel.selectedCount > 0 {
                    Text("\(viewModel.selectedCount)枚")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(Color(red: 0.5, green: 0.25, blue: 0.05))
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(
                            Capsule()
                                .fill(Color(red: 0.96, green: 0.88, blue: 0.70))
                                .overlay(
                                    Capsule()
                                        .strokeBorder(Color(red: 0.75, green: 0.5, blue: 0.2), lineWidth: 1)
                                )
                        )
                }

                // Role guide button
                Button {
                    showRoleGuide = true
                } label: {
                    Image(systemName: "list.bullet.rectangle")
                        .font(.system(size: 18))
                        .foregroundColor(Color(red: 0.45, green: 0.2, blue: 0.05))
                }

                // Reset button
                Button {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        viewModel.reset()
                    }
                } label: {
                    Image(systemName: "arrow.counterclockwise")
                        .font(.system(size: 18))
                        .foregroundColor(Color(red: 0.45, green: 0.2, blue: 0.05))
                }
            }
        }
    }
}

// MARK: - Role Guide Sheet

struct RoleGuideSheet: View {
    @Environment(\.dismiss) private var dismiss

    private let roles = KoiKoiRole.allRoles

    var body: some View {
        NavigationView {
            List {
                ForEach(roles) { role in
                    RoleGuideRow(role: role)
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("役一覧")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("閉じる") { dismiss() }
                }
            }
        }
    }
}

// MARK: - Role Guide Row

struct RoleGuideRow: View {
    let role: KoiKoiRole

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text(role.name)
                    .font(.system(size: 16, weight: .bold, design: .rounded))
                    .foregroundColor(Color(red: 0.35, green: 0.1, blue: 0.02))
                Text(role.nameRomaji)
                    .font(.system(size: 12))
                    .foregroundColor(Color(.systemGray2))
                Spacer()
                Text(role.isVariable ? "\(role.basePoints)点〜" : "\(role.basePoints)点")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(Color(red: 0.65, green: 0.18, blue: 0.05))
            }
            Text(role.description)
                .font(.system(size: 12))
                .foregroundColor(Color(.systemGray))
        }
        .padding(.vertical, 4)
    }
}

// MARK: - Preview

#Preview {
    ContentView()
}

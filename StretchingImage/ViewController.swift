import UIKit

private enum Constants {
    static let imageHeight: CGFloat = 270
    static let fakeContentHeight: CGFloat = 1500
}

final class ViewController: UIViewController {
    private let scrollView: UIScrollView = UIScrollView()
    private let imageView: UIImageView = UIImageView()
    private let fakeContent: UIView = UIView()
    private let imageContainer: UIView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

extension ViewController {
    private func setupUI() {
        view.backgroundColor = .white
        setupScrollView()
        setupImageView()
        setupFackContent()
    }

    private func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.delegate = self
        scrollView.contentInsetAdjustmentBehavior = .never
        view.addSubview(scrollView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func setupImageView() {
        imageContainer.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(imageContainer)

        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "header")
        imageView.contentMode = .scaleAspectFill
        scrollView.addSubview(imageView)

        let imageTopAnchor = imageView.topAnchor.constraint(equalTo: view.topAnchor)
        imageTopAnchor.priority = .defaultHigh

        NSLayoutConstraint.activate([
            imageContainer.topAnchor.constraint(
                equalTo: scrollView.contentLayoutGuide.topAnchor
            ),
            imageContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageContainer.heightAnchor.constraint(
                equalToConstant: Constants.imageHeight
            ),

            imageTopAnchor,
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: imageContainer.bottomAnchor),
            imageView.heightAnchor.constraint(
                greaterThanOrEqualToConstant: Constants.imageHeight
            ),
        ])
    }

    private func setupFackContent() {
        fakeContent.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(fakeContent)

        NSLayoutConstraint.activate([
            fakeContent.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            fakeContent.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            fakeContent.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            fakeContent.bottomAnchor.constraint(
                equalTo: scrollView.contentLayoutGuide.bottomAnchor
            ),
            fakeContent.heightAnchor.constraint(
                equalToConstant: Constants.fakeContentHeight
            )
        ])

    }
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        let topInset = Constants.imageHeight + (offset <= .zero ? -offset : 0) - view.safeAreaInsets.top
        scrollView.verticalScrollIndicatorInsets.top = topInset
    }
}

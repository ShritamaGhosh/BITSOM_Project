
db.products.find(
    { category: "Electronics", price: { $lt: 50000 } },
    { name: 1, price: 1, stock: 1, _id: 0 }
);


db.products.aggregate([
    { $project: { name: 1, avgRating: { $avg: "$reviews.rating" } } },
    { $match: { avgRating: { $gte: 4.0 } } }
]);


db.products.aggregate([
    {
        $group: {
            _id: "$category",
            avg_price: { $avg: "$price" },
            product_count: { $sum: 1 }
        }
    },
    { $sort: { avg_price: -1 } }
]);

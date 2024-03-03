const std = @import("std");

pub fn yell(str: []u8) void {
    for (str) |*byte| {
        // if (byte >= 97 and byte <= 122) {
        //     byte -= 32;
        // }

        byte.* = std.ascii.toUpper(byte.*);
    }
}

pub fn main() !void {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    var allocator = arena.allocator();
    var args = try std.process.argsWithAllocator(allocator);
    defer args.deinit();
    _ = args.skip();
    // std.debug.print("\nargs: {s}\n", .{args.next().?});

    const writer = std.io.getStdOut().writer();
    var str = args.next().?;
    var buffer: []u8 = try allocator.alloc(u8, str.len);
    for (str, 0..) |ch, i| {
        buffer[i] = ch;
    }

    yell(buffer);
    _ = try writer.print("{s}", .{buffer});
}

test "simple test" {
    // var list = std.ArrayList(i32).init(std.testing.allocator);
    // defer list.deinit(); // try commenting this out and see if zig detects the memory leak!
    // try list.append(42);
    // try std.testing.expectEqual(@as(i32, 42), list.pop());
}

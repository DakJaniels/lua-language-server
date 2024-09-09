do
    local a = ls.node.type('number')

    assert(a:view() == 'number')
end


do
    local a = ls.node.create()
    local b = ls.node.type('never')

    assert(a:view() == 'never')
    assert(b:view() == 'never')
end

do
    local a = ls.node.any()
    local b = ls.node.type('any')

    assert(a:view() == 'any')
    assert(b:view() == 'any')
end

do
    local a = ls.node.unknown()
    local b = ls.node.type('unknown')

    assert(a:view() == 'unknown')
    assert(b:view() == 'unknown')
end

do
    local a = ls.node.value(1)

    assert(a:view() == '1')
end

do
    local a = ls.node.value(1.2345)

    assert(a:view() == '1.2345')
end

do
    local a = ls.node.value(true)

    assert(a:view() == 'true')
end

do
    local a = ls.node.value(false)

    assert(a:view() == 'false')
end

do
    local a = ls.node.value('abc', '"')

    assert(a:view() == '"abc"')
end

do
    local a = ls.node.value('abc', "'")

    assert(a:view() == "'abc'")
end

do
    local a = ls.node.value('abc', "[[")

    assert(a:view() == "[[abc]]")
end

do
    local a = ls.node.type('number') | ls.node.type('string')

    assert(a:view() == 'number|string')
end

do
    local a = ls.node.union(ls.node.value(1), ls.node.value(2))

    assert(a:view() == '1|2')
end

do
    local a = ls.node.value(1) | ls.node.value(2)

    assert(a:view() == '1|2')
end

do
    local a = ls.node.value(1) | ls.node.value(2) | ls.node.value(3)

    assert(a:view() == '1|2|3')
end

do
    local a = (ls.node.value(1) | ls.node.value(2)) | (ls.node.value(1) | ls.node.value(3))

    assert(a:view() == '1|2|3')
end

do
    local a = ls.node.create() | ls.node.value(1)

    assert(a:view() == '1')
end

do
    local a = ls.node.value(1) | ls.node.create()

    assert(a:view() == '1')
end

do
    local a = ls.node.value(1) | nil

    assert(a:view() == '1')
end

do
    local a = nil | ls.node.value(1)

    assert(a:view() == '1')
end

do
    local t = ls.node.table()
        : insert(ls.node.value('x'), ls.node.value(1))
        : insert(ls.node.value('y'), ls.node.value(2))
        : insert(ls.node.value('z'), ls.node.value(3))
        : insert(ls.node.value(1), ls.node.value('x'))
        : insert(ls.node.value(2), ls.node.value('y'))
        : insert(ls.node.value(3), ls.node.value('z'))

    assert(t:view() == [[{ [1]: "x", [2]: "y", [3]: "z", x: 1, y: 2, z: 3 }]])
end

do
    local func = ls.node.func()
        : addParam('a', ls.node.value(1))
        : addParam('b', ls.node.value(2))
        : addReturn('suc', ls.node.value(true))
        : addReturn(nil, ls.node.value(false))

    assert(func:view() == 'fun(a: 1, b: 2):true, false')
end

do
    local class = ls.node.def('A')

    assert(class:view() == 'A')

    class:asClass()
    assert(class:view() == 'class A')

    local alias = ls.node.def('B')

    alias:asAlias()
    assert(alias:view() == 'alias B')

    local enum = ls.node.def('C')

    enum:asEnum()
    assert(enum:view() == 'enum C')
end

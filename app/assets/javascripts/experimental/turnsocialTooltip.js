! function () {
    window.turnsocial_has_run = !1;
    var t = {
        captureException: function (t) {
            throw t
        },
        wrap: function (t, e) {
            return "function" == typeof t && (e = t, t = void 0),
            function () {
                e.apply(this, arguments)
            }
        }
    }, e = t.wrap(function (e, i) {
            function n(e) {
                var i = {};
                i.name = e.name, i.icon = e.icon || e.name, i.description = e.description || n.convert_name_to_description(e.name), i.protected = !! e.protected, i.draw_button = e.draw_button || function () {
                    return s("<img />", {
                        src: b[i.name],
                        alt: i.description
                    })
                };
                var o = e.click || function () {
                        i.activate()
                    }, r = function () {
                        p.track("app opened", {
                            name: i.name
                        }), o()
                    };
                return i.link = s("<div />", {
                    "class": "ts_app_link",
                    id: "ts_" + i.name + "_link",
                    click: t.wrap(r)
                }), i.protected ? c.find("#ts_protected_links").append(i.link) : c.find("#ts_app_links").append(i.link), i.link.append(i.draw_button()), i
            }

            function o(e) {
                var i = n(e);
                i.onload = e.onload || function () {}, i.type = e.type, i.loaded = e.loaded || !1, i.shadow = "undefined" == typeof e.shadow ? !0 : e.shadow, i.load_content = i.load_content || e.load_content, i.on_close = e.on_close, i.app_window = s("<div />", {
                    id: "ts_" + i.name,
                    "class": "ts_widget ts_" + i.type
                }), i.display_div = s("<div />", {
                    "class": "ts_display_div"
                });
                var o = s("<div />", {
                    "class": "ts_title_bar"
                }),
                    r = s("<div />", {
                        "class": "ts_close_button",
                        click: t.wrap(function () {
                            i.deactivate()
                        })
                    });
                return o.append(r), i.app_window.append(o), i.app_window.append(i.display_div), c.append(i.app_window), i.display_div.prevent_scroll(), i.activate = function () {
                    if (i == n.active_app) return i.deactivate(), void 0;
                    n.active_app && n.active_app.deactivate(!0), n.active_app = i;
                    var t = i.show_app_window();
                    if (s(document).bind("keydown.ts_abort", function (t) {
                        27 == t.keyCode && (s(document).unbind("keydown.ts_abort"), i.deactivate())
                    }), !i.loaded) {
                        var e = i.app_window.height_defined();
                        e || i.app_window.height(i.app_window.width());
                        var o = !1;
                        i.display_div.html("");
                        var r = v(i.display_div);
                        i.error = function (t) {
                            if (!o && !i.loaded) {
                                o = !0, r.stop();
                                var e = s("<div />", {
                                    "class": "ts_error",
                                    text: t
                                });
                                i.display_div.html(e), e.css("margin-top", -e.outerHeight() / 2)
                            }
                        }, setTimeout(function () {
                            i.error("The application timed out. Please refresh the page and try again.")
                        }, 15e3), i.load_content(function () {
                            if (i.loaded = !0, r.stop(), i.onload(), !e) {
                                i.app_window.css({
                                    height: "auto"
                                });
                                var n = Math.min(i.app_window.height(), 1500),
                                    o = function () {
                                        var t = i.app_window.offset().top - s(document).scrollTop(),
                                            e = 60;
                                        e > t && i.app_window.css({
                                            top: e,
                                            height: "auto"
                                        });
                                        var o = i.app_window.height();
                                        o > n && i.app_window.css({
                                            top: "auto",
                                            height: n
                                        })
                                    };
                                s(window).bind("resize.ts_resize_app", o), s.when(t).then(o)
                            }
                        })
                    }
                }, i.deactivate = function (t) {
                    i == n.active_app && (n.active_app = null, s(window).unbind("resize.ts_resize_app"), t || s("#ts_shadow").hide(), i.app_window.fadeOut(200), "function" == typeof i.on_close && i.on_close())
                }, i.show_app_window = function () {
                    var t = s("#ts_shadow"),
                        e = s.Deferred();
                    return i.shadow ? t.fadeTo(200, .3, function () {
                        i.app_window.fadeIn(200), setTimeout(e.resolve, 1)
                    }) : (i.app_window.fadeIn(200), setTimeout(e.resolve, 1)), e
                }, i.reload = function () {
                    i.deactivate(!0), i.loaded = !1, i.activate()
                }, i
            }

            function r(e) {
                var i = o(s.extend(e, {
                    type: "iframe_app"
                }));
                return i.src = e.src, i.scrollable = e.scrollable || !1, i.load_content = function (e) {
                    i.iframe = s('<iframe src="' + i.src + '" ' + 'marginwidth="0" marginheight="0" vspace="0" hspace="0" ' + 'allowtransparency="true" frameborder="0" scrolling="no"></iframe>'), i.display_div.append(i.iframe), i.iframe.width(0).height(0), i.iframe.load(t.wrap(function () {
                        i.iframe.siblings().remove(), i.iframe.width("100%"), i.iframe.height("100%"), e()
                    }))
                }, i
            }

            function a(e) {
                var i = o(s.extend(e, {
                    type: "json_app"
                }));
                return i.url = e.url, i.display = e.display, i.styles = e.styles, i.load_content = function (e) {
                    s.jsonp({
                        url: i.url,
                        success: function (n) {
                            try {
                                var o = i.display(n);
                                i.display_div.html(o), e()
                            } catch (r) {
                                i.error("Whoops... There was an error. We're working on fixing it now!"), t.captureException(r)
                            }
                        },
                        error: function (e) {
                            i.error("Error loading data. Refresh the page and try again."), t.captureException(e)
                        }
                    })
                }, i
            }
            if (!turnsocial_has_run) {
                turnsocial_has_run = !0, "undefined" == typeof console && (this.console = {
                    log: function () {}
                });
                var s = e;
                ! function (t) {
                    function e() {}

                    function i(t) {
                        a = [t]
                    }

                    function n(t, e, i) {
                        return t && t.apply(e.context || e, i)
                    }

                    function o(t) {
                        return /\?/.test(t) ? "&" : "?"
                    }

                    function r(r) {
                        function h(t) {
                            V++ || (q(), L && (C[K] = {
                                s: [t]
                            }), W && (t = W.apply(r, [t])), n(R, r, [t, _, r]), n(M, r, [r, _]))
                        }

                        function j(t) {
                            V++ || (q(), L && t != y && (C[K] = t), n(F, r, [r, t]), n(M, r, [r, t]))
                        }
                        r = t.extend({}, E, r);
                        var Q, z, O, U, B, R = r.success,
                            F = r.error,
                            M = r.complete,
                            W = r.dataFilter,
                            H = r.callbackParameter,
                            P = r.callback,
                            J = r.cache,
                            L = r.pageCache,
                            Y = r.charset,
                            K = r.url,
                            N = r.data,
                            X = r.timeout,
                            V = 0,
                            q = e;
                        return k && k(function (t) {
                            t.done(R).fail(F), R = t.resolve, F = t.reject
                        }).promise(r), r.abort = function () {
                            !V++ && q()
                        }, n(r.beforeSend, r, [r]) === !1 || V ? r : (K = K || c, N = N ? "string" == typeof N ? N : t.param(N, r.traditional) : c, K += N ? o(K) + N : c, H && (K += o(K) + encodeURIComponent(H) + "=?"), !J && !L && (K += o(K) + "_" + (new Date).getTime() + "="), K = K.replace(/=\?(&|$)/, "=" + P + "$1"), L && (Q = C[K]) ? Q.s ? h(Q.s[0]) : j(Q) : (x[P] = i, O = t(b)[0], O.id = u + S++, Y && (O[l] = Y), T && T.version() < 11.6 ? (U = t(b)[0]).text = "document.getElementById('" + O.id + "')." + A + "()" : O[s] = s, D && (O.htmlFor = O.id, O.event = f), O[g] = O[A] = O[m] = function (t) {
                            if (!O[w] || !/i/.test(O[w])) {
                                try {
                                    O[f] && O[f]()
                                } catch (e) {}
                                t = a, a = 0, t ? h(t[0]) : j(d)
                            }
                        }, O.src = K, q = function () {
                            B && clearTimeout(B), O[m] = O[g] = O[A] = null, I[v](O), U && I[v](U)
                        }, I[p](O, z = I.firstChild), U && I[p](U, z), B = X > 0 && setTimeout(function () {
                            j(y)
                        }, X)), r)
                    }
                    var a, s = "async",
                        l = "charset",
                        c = "",
                        d = "error",
                        p = "insertBefore",
                        u = "_jqjsp",
                        h = "on",
                        f = h + "click",
                        A = h + d,
                        g = h + "load",
                        m = h + "readystatechange",
                        w = "readyState",
                        v = "removeChild",
                        b = "<script>",
                        _ = "success",
                        y = "timeout",
                        x = window,
                        k = t.Deferred,
                        I = t("head")[0] || document.documentElement,
                        C = {}, S = 0,
                        E = {
                            callback: u,
                            url: location.href
                        }, T = x.opera,
                        D = !! t("<div>").html("<!--[if IE]><i><![endif]-->").find("i").length;
                    r.setup = function (e) {
                        t.extend(E, e)
                    }, t.jsonp = r
                }(e);
                var l = {};
                ! function (t) {
                    var e = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"],
                        i = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"],
                        n = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"],
                        o = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"],
                        r = {
                            1: "st",
                            2: "nd",
                            3: "rd",
                            "default": "th"
                        };
                    t.extend_date = function () {
                        Date.strptime = t.strptime, Date.prototype.strftime = function (e) {
                            return t.strftime(this, e)
                        }
                    };
                    var a = {
                        daysInMonth: function (t) {
                            var e = a.isLeapYear(t) ? 29 : 28;
                            return [31, e, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
                        },
                        getTimezone: function (t) {
                            return t.toString().replace(/^.*? ([A-Z]{3}) [0-9]{4}.*$/, "$1").replace(/^.*?\(([A-Z])[a-z]+ ([A-Z])[a-z]+ ([A-Z])[a-z]+\)$/, "$1$2$3")
                        },
                        getGMTOffset: function (t) {
                            return (t.getTimezoneOffset() > 0 ? "-" : "+") + c.pad(Math.floor(t.getTimezoneOffset() / 60), 2) + c.pad(t.getTimezoneOffset() % 60, 2)
                        },
                        getDayOfYear: function (t) {
                            for (var e = 0, i = 0; i < t.getMonth(); ++i) e += a.daysInMonth(t)[i];
                            return e + t.getDate()
                        },
                        getWeekOfYear: function (t, e) {
                            var i = this.getDayOfYear(t) + (e - t.getDay()),
                                n = new Date(t.getFullYear(), 0, 1),
                                o = 7 - n.getDay() + e;
                            return c.pad(Math.floor((i - o) / 7) + 1, 2)
                        },
                        isLeapYear: function (t) {
                            var e = t.getFullYear();
                            return !(0 != (3 & e) || !(e % 100 || 0 == e % 400 && e))
                        },
                        getFirstDayOfMonth: function (t) {
                            var e = (t.getDay() - (t.getDate() - 1)) % 7;
                            return 0 > e ? e + 7 : e
                        },
                        getLastDayOfMonth: function (t) {
                            var e = (t.getDay() + (a.daysInMonth(t)[t.getMonth()] - t.getDate())) % 7;
                            return 0 > e ? e + 7 : e
                        },
                        getSuffix: function (t) {
                            var e = t.getDate().toString(),
                                i = parseInt(e.slice(-1));
                            return r[i] || r["default"]
                        },
                        applyOffset: function (t, e) {
                            return t.setTime(t.valueOf() - 1e3 * e), t
                        },
                        century: function (t) {
                            return parseInt(t.getFullYear().toString().substring(0, 2), 10)
                        }
                    }, l = {
                            values_of: function (t) {
                                var e = [];
                                return s.each(t, function (t, i) {
                                    e.push(i)
                                }), e
                            }
                        }, c = {
                            pad: function (t, e, i) {
                                i || (i = "0");
                                for (var n = t.toString(), o = e - n.length; o-- > 0;) n = i + n;
                                return n
                            }
                        }, d = {
                            a: function (t) {
                                return o[t.getDay()]
                            },
                            A: function (t) {
                                return n[t.getDay()]
                            },
                            b: function (t) {
                                return i[t.getMonth()]
                            },
                            B: function (t) {
                                return e[t.getMonth()]
                            },
                            c: function (t) {
                                return t.toLocaleString()
                            },
                            C: function (t) {
                                return a.century(t)
                            },
                            d: function (t) {
                                return c.pad(t.getDate(), 2)
                            },
                            e: function (t) {
                                return c.pad(t.getDate(), 2, " ")
                            },
                            H: function (t) {
                                return c.pad(t.getHours(), 2)
                            },
                            I: function (t) {
                                return c.pad(t.getHours() % 12 || 12, 2)
                            },
                            j: function (t) {
                                return c.pad(a.getDayOfYear(t), 3)
                            },
                            k: function (t) {
                                return c.pad(t.getHours(), 2, " ")
                            },
                            l: function (t) {
                                return c.pad(t.getHours() % 12 || 12, 2, " ")
                            },
                            L: function (t) {
                                return c.pad(t.getMilliseconds(), 3)
                            },
                            m: function (t) {
                                return c.pad(t.getMonth() + 1, 2)
                            },
                            M: function (t) {
                                return c.pad(t.getMinutes(), 2)
                            },
                            p: function (t) {
                                return t.getHours() < 12 ? "AM" : "PM"
                            },
                            P: function (t) {
                                return t.getHours() < 12 ? "am" : "pm"
                            },
                            q: function (t) {
                                return a.getSuffix(t)
                            },
                            s: function (t) {
                                return Math.round(t.valueOf() / 1e3)
                            },
                            S: function (t) {
                                return c.pad(t.getSeconds(), 2)
                            },
                            u: function (t) {
                                return t.getDay() || 7
                            },
                            U: function (t) {
                                return a.getWeekOfYear(t, 0)
                            },
                            w: function (t) {
                                return t.getDay()
                            },
                            W: function (t) {
                                return a.getWeekOfYear(t, 1)
                            },
                            x: function (t) {
                                return t.toLocaleDateString()
                            },
                            X: function (t) {
                                return t.toLocaleTimeString()
                            },
                            y: function (t) {
                                return t.getFullYear().toString().substring(2, 4)
                            },
                            Y: function (t) {
                                return t.getFullYear()
                            },
                            z: function (t) {
                                var e = 100 * (t.getTimezoneOffset() / 60);
                                return (e > 0 ? "-" : "+") + c.pad(e, 4)
                            },
                            "%": function () {
                                return "%"
                            }
                        };
                    d.h = d.b, d.N = d.L;
                    var p = {
                        a: {
                            r: "(?:" + o.join("|") + ")"
                        },
                        A: {
                            r: "(?:" + n.join("|") + ")"
                        },
                        b: {
                            r: "(" + i.join("|") + ")",
                            p: function (t) {
                                this.month = s.inArray(t, i)
                            }
                        },
                        B: {
                            r: "(" + e.join("|") + ")",
                            p: function (t) {
                                this.month = s.inArray(t, e)
                            }
                        },
                        C: {
                            r: "(\\d{1,2})",
                            p: function (t) {
                                this.century = parseInt(t, 10)
                            }
                        },
                        d: {
                            r: "(\\d{1,2})",
                            p: function (t) {
                                this.day = parseInt(t, 10)
                            }
                        },
                        H: {
                            r: "(\\d{1,2})",
                            p: function (t) {
                                this.hour = parseInt(t, 10)
                            }
                        },
                        j: {
                            r: "(\\d{1,3})",
                            p: function (t) {
                                this.day = parseInt(t, 10)
                            }
                        },
                        L: {
                            r: "(\\d{3})",
                            p: function (t) {
                                this.milliseconds = parseInt(t, 10)
                            }
                        },
                        m: {
                            r: "(\\d{1,2})",
                            p: function (t) {
                                this.month = parseInt(t, 10) - 1
                            }
                        },
                        M: {
                            r: "(\\d{2})",
                            p: function (t) {
                                this.minute = parseInt(t, 10)
                            }
                        },
                        M: {
                            r: "(\\d{2})",
                            p: function (t) {
                                this.minute = parseInt(t, 10)
                            }
                        },
                        p: {
                            r: "(AM|PM)",
                            p: function (t) {
                                "AM" == t ? 12 == this.hour && (this.hour = 0) : this.hour < 12 && (this.hour += 12)
                            }
                        },
                        P: {
                            r: "(am|pm)",
                            p: function (t) {
                                "am" == t ? 12 == this.hour && (this.hour = 0) : this.hour < 12 && (this.hour += 12)
                            }
                        },
                        q: {
                            r: "(?:" + l.values_of(r).join("|") + ")"
                        },
                        S: {
                            r: "(\\d{2})",
                            p: function (t) {
                                this.second = parseInt(t, 10)
                            }
                        },
                        y: {
                            r: "(\\d{1,2})",
                            p: function (t) {
                                this.year = parseInt(t, 10)
                            }
                        },
                        Y: {
                            r: "(\\d{4})",
                            p: function (t) {
                                this.century = Math.floor(parseInt(t, 10) / 100), this.year = parseInt(t, 10) % 100
                            }
                        },
                        z: {
                            r: "(Z|[+-]\\d{2}:?\\d{2})",
                            p: function (t) {
                                if ("Z" == t) return this.zone = 0, void 0;
                                var e = 3600 * parseInt(t[0] + t[1] + t[2], 10);
                                e += ":" == t[3] ? 60 * parseInt(t[4] + t[5], 10) : 60 * parseInt(t[3] + t[4], 10), this.zone = e
                            }
                        }
                    };
                    p.e = p.d, p.h = p.b, p.I = p.H, p.k = p.H, p.l = p.H, t.strftime = function (t, e) {
                        for (var i = "", n = e;;) {
                            var o = /%./g,
                                r = o.exec(n);
                            if (!r) return i + n;
                            i += n.slice(0, o.lastIndex - 2), n = n.slice(o.lastIndex);
                            var a = r[0].charAt(1),
                                s = d[a];
                            i += s ? s.call(this, t) : "%" + a
                        }
                    }, t.strptime = function (t, e) {
                        for (var i = [], n = "", o = e;;) {
                            var r = /%./g,
                                l = r.exec(o);
                            if (!l) {
                                n += o;
                                break
                            }
                            n += o.slice(0, r.lastIndex - 2), o = o.slice(r.lastIndex);
                            var c = l[0].charAt(1),
                                d = p[c];
                            d.p && (i = i.concat(d.p)), n += d.r
                        }
                        var n = new RegExp("^" + n + "$"),
                            u = t.match(n) || [];
                        if (u.length != i.length + 1) return null;
                        var h = {};
                        s.each(i, function (t, e) {
                            e.call(h, u[t + 1])
                        });
                        var f = new Date;
                        if ("year" in h)
                            if ("century" in h) h.year += 100 * h.century;
                            else {
                                h.year += 100 * a.century(f);
                                var A = new Date(f.getFullYear() + 50, f.getMonth(), f.getDate());
                                h.year > A.getFullYear() && (h.year -= 100)
                            }
                        if ("year" in h && "day" in h && !("month" in h))
                            for (var g = new Date(h.year, 0, 1), m = a.daysInMonth(g), w = 0; w < m.length; w++) {
                                if (h.day <= m[w]) {
                                    h.month = w;
                                    break
                                }
                                h.day -= m[w]
                            }
                        var v = new Date("year" in h ? h.year : f.getFullYear(), "month" in h ? h.month : f.getMonth(), "day" in h ? h.day : f.getDate(), h.hour || 0, h.minute || 0, h.second || 0, h.milliseconds || 0);
                        return "zone" in h ? (v = new Date(v.valueOf() - 60 * 1e3 * v.getTimezoneOffset()), a.applyOffset(v, h.zone || 0)) : v
                    }
                }(l);
                var c = s('<div id="ts" class="ts"> <div class="ts_bar"> <div id="ts_app_links"><div id="google_translate_element"></div></div> <div id="ts_protected_links"></div> </div> <div id="ts_shadow"></div> </div>'),
                    d = '#ts h1,#ts h2,#ts h3,#ts h4,#ts h5,#ts h6,#ts p,#ts td,#ts dl,#ts tr,#ts dt,#ts ol,#ts form,#ts select,#ts option,#ts pre,#ts div,#ts table,#ts th,#ts tbody,#ts tfoot,#ts caption,#ts thead,#ts ul,#ts li,#ts address,#ts blockquote,#ts dd,#ts fieldset,#ts li,#ts iframe,#ts strong,#ts legend,#ts em,#ts s,#ts cite,#ts span,#ts input,#ts sup,#ts label,#ts dfn,#ts object,#ts big,#ts q,#ts font,#ts samp,#ts acronym,#ts small,#ts img,#ts strike,#ts code,#ts sub,#ts ins,#ts textarea,#ts var,#ts a,#ts abbr,#ts applet,#ts del,#ts kbd,#ts tt,#ts b,#ts i,#ts hr,#ts article,#ts aside,#ts dialog,#ts figure,#ts footer,#ts header,#ts hgroup,#ts menu,#ts nav,#ts section,#ts time,#ts mark,#ts audio,#ts video{background-attachment:scroll;background-color:transparent;background-image:none;background-position:0 0;background-repeat:repeat;border-color:black;border-radius:0;border-style:none;border-width:medium;bottom:auto;clear:none;clip:auto;color:inherit;counter-increment:none;counter-reset:none;cursor:auto;direction:inherit;display:inline;float:none;font-family:inherit;font-size:inherit;font-style:inherit;font-variant:normal;font-weight:inherit;height:auto;left:auto;letter-spacing:normal;line-height:inherit;list-style-type:none;list-style-position:outside;list-style-image:none;margin:0;max-height:none;max-width:none;min-height:0;min-width:0;opacity:1;outline:invert none medium;overflow:visible;padding:0;position:static;quotes:"" "";right:auto;table-layout:auto;text-align:inherit;text-decoration:inherit;text-indent:0;text-transform:none;top:auto;unicode-bidi:normal;vertical-align:baseline;visibility:inherit;white-space:normal;width:auto;word-spacing:normal;z-index:auto;-moz-border-radius:0;-webkit-border-radius:0}#ts h3,#ts h5,#ts p,#ts h1,#ts dl,#ts dt,#ts h6,#ts ol,#ts form,#ts select,#ts option,#ts pre,#ts div,#ts h2,#ts caption,#ts h4,#ts ul,#ts address,#ts blockquote,#ts dd,#ts fieldset,#ts textarea,#ts hr,#ts article,#ts aside,#ts dialog,#ts figure,#ts footer,#ts header,#ts hgroup,#ts menu,#ts nav,#ts section{display:block}#ts table{display:table}#ts thead{display:table-header-group}#ts tbody{display:table-row-group}#ts tfoot{display:table-footer-group}#ts tr{display:table-row}#ts th,#ts td{display:table-cell}#ts li{display:list-item;min-height:auto;min-width:auto}#ts strong{font-weight:bold}#ts em{font-style:italic}#ts kbd,#ts samp,#ts code{font-family:monospace}#ts a,#ts a,#ts *,#ts input[type=submit],#ts input[type=radio],#ts input[type=checkbox],#ts select{cursor:pointer}#ts a:hover{text-decoration:none}#ts button,#ts input[type=submit]{text-align:center}#ts input[type=hidden]{display:none}#ts abbr[title],#ts acronym[title],#ts dfn[title]{cursor:help;border-bottom-width:1px;border-bottom-style:dotted}#ts ins{background-color:#ff9;color:black}#ts del{text-decoration:line-through}#ts blockquote,#ts q{quotes:none}#ts blockquote:before,#ts blockquote:after,#ts q:before,#ts q:after,#ts li:before,#ts li:after{content:""}#ts input,#ts select{vertical-align:middle}#ts select,#ts textarea,#ts input{border:1px solid #ccc}#ts table{border-collapse:collapse;border-spacing:0}#ts hr{display:block;height:1px;border:0;border-top:1px solid #ccc;margin:1em 0}#ts *[dir=rtl]{direction:rtl}#ts mark{background-color:#ff9;color:black;font-style:italic;font-weight:bold}#ts{font-size:medium;line-height:1;direction:ltr;text-align:left;font-family:"Times New Roman", Times, serif;color:black;font-style:normal;font-weight:normal;text-decoration:none;list-style-type:disc;display:block}\n';
                d += "#ts *{-webkit-box-sizing:border-box;-moz-box-sizing:border-box;box-sizing:border-box}#ts .ts_bar{position:fixed;bottom:0;right:13px;height:37px;z-index:2147483645;display:none;overflow:hidden;white-space:nowrap;padding:4px 8px 0 8px;box-shadow:0 0 4px 0 rgba(0,0,0,0.2);background:rgba(255,255,255,0.9);border:2px solid rgba(116,147,208,0.8);border-bottom:none;border-radius:8px 8px 0 0}#ts .ts_bar .ts_bar a:hover{text-decoration:none}#ts .ts_bar .ts_bar a{text-decoration:none;outline:none}#ts #ts_app_links,#ts #ts_protected_links{float:left}#ts .ts_app_link{display:inline-block;padding:0 3px;cursor:pointer;vertical-align:middle}#ts .ts_app_link *{cursor:pointer}#ts .ts_error{position:absolute;top:50%;left:50%;margin-left:-120px;width:220px;border-radius:14px;line-height:18px;text-align:center;background-color:#fdd;color:#b00;font-weight:bold;padding:10px}#ts .ts_spinner{position:absolute;left:50%;top:50%;height:18px}#ts .ts_spinner_segment{position:absolute;width:14px;height:14px;background-color:white;border:solid 2px #7493d0;border-radius:14px}#ts #ts_shadow{background-color:black;position:fixed;left:0;top:0;right:0;bottom:0;z-index:2147483644;display:none}#ts .ts_display_div{height:100%}#ts .ts_json_app .ts_display_div{padding:10px;overflow-y:auto}#ts .ts_iframe_app .ts_display_div{overflow:hidden}#ts .ts_widget{font-family:Arial, sans-serif;display:none;background-color:white;position:fixed;border:2px solid #88a3d7;z-index:2147483645;bottom:43px;right:13px;font-size:13px;overflow:hidden;padding:22px 0 0 0}#ts .ts_widget a{color:#7D99CC;text-decoration:none}#ts .ts_widget a:hover{text-decoration:underline}#ts .ts_widget h1{font-size:28px;font-weight:bold}#ts .ts_widget h2{font-size:18px;font-weight:bold}#ts .ts_widget .ts_title_bar{position:absolute;height:22px;left:0;right:0;top:0;background-color:#88a3d7}#ts .ts_widget .ts_title_bar .ts_close_button{position:absolute;display:block;cursor:pointer;right:4px;top:3px;width:15px;height:15px;background:url(//turnsocial.com/assets/close_window-bd510b5dc145fdef77ccd93c825ffb69.png) no-repeat 0 0}#ts .ts_widget .ts_title_bar .ts_close_button:hover{background-position:0 -16px}#ts .ts_widget .ts_title_bar .ts_close_button:active{background-position:0 -32px}#ts .ts_iframe_app iframe{width:100%;height:100%;overflow-x:hidden;overflow-y:auto}#ts #ts_facebook_fan{width:500px;height:560px}#ts #ts_walkscore{width:600px;height:442px}#ts #ts_walkscore iframe{overflow:hidden}#ts #ts_linkedin{display:inline-block;min-width:93px}#ts #ts_youtube{width:580px;height:560px}#ts #ts_satisfacts{width:460px;height:340px;left:50%;margin-left:-230px;top:50%;margin-top:-170px;border-radius:12px}#ts #ts_satisfacts iframe{overflow:hidden}#ts #google_translate_element{width:auto;height:23px;overflow:hidden;left:270px;position:absolute;top:5px;margin-left:10px;border:1px solid #7D9FD7; border-radius: 4px 4px 4px 4px;background-color:#E0E0E0;ts_app_linksts_app_links} #ts_tweet_button{width:100px;height:20px;overflow:hidden}#ts #ts_google_plusone{width:80px;height:20px;overflow:hidden}#ts #ts_facebook_like{width:90px;height:20px;overflow:hidden}#ts #ts_ads{width:300px;height:250px;overflow:hidden}#ts .ts_tooltip{display:none;border:3px solid #333;border-radius:8px;background-color:#505050;padding:5px 9px;position:fixed;left:0;top:0;overflow:hidden;text-align:center;z-index:2147483647;font-family:sans-serif;color:#f3f3f3;letter-spacing:0.05em;white-space:nowrap;font-size:12px}#ts .default_height_check{height:1337px}\n";
                var p;
                p = {
                    track: function (t, e) {
                        var i, n, o, r;
                        return null == e && (e = {}), s.extend(e, {
                            event: t
                        }), n = "xxxxxxxx".replace(/x/g, function () {
                            return (0 | 16 * Math.random()).toString(16)
                        }), o = (new Date).getTime(), r = "//turnsocial.com/track/" + n + "-" + o + ".gif?" + s.param(e), i = s("<img />", {
                            "class": "ts_analytics",
                            style: "display: none !important;",
                            width: 0,
                            height: 0
                        }), i.load(function () {
                            return i.remove()
                        }), i.attr("src", r), s("body").append(i)
                    }
                };
                var u = {
                    bind: function (t, e, i) {
                        var n = this._callbacks || (this._callbacks = {}),
                            o = n[t] || (n[t] = []);
                        return o.push([e, i]), this
                    },
                    unbind: function (t, e) {
                        var i;
                        if (t) {
                            if (i = this._callbacks)
                                if (e) {
                                    var n = i[t];
                                    if (!n) return this;
                                    for (var o = 0, r = n.length; r > o; o++)
                                        if (n[o] && e === n[o][0]) {
                                            n[o] = null;
                                            break
                                        }
                                } else i[t] = []
                        } else this._callbacks = {};
                        return this
                    },
                    trigger: function (t) {
                        var e, i, n, o, r, a = 2;
                        if (!(i = this._callbacks)) return this;
                        for (; a--;)
                            if (n = a ? t : "all", e = i[n])
                                for (var s = 0, l = e.length; l > s; s++)(o = e[s]) ? (r = a ? Array.prototype.slice.call(arguments, 1) : arguments, o[0].apply(o[1] || this, r)) : (e.splice(s, 1), s--, l--);
                        return this
                    }
                };
                u.bind("insert", function () {
                    c.find("#ts_shadow").bind("click", function () {
                        return n.active_app.deactivate(), !1
                    }), s(".ts_widget").on("click", "a", function (t) {
                        return t.stopPropagation(), window.open(this.href), !1
                    })
                }),
                function (t) {
                    function e(e) {
                        var n = e || window.event,
                            o = [].slice.call(arguments, 1),
                            r = 0,
                            a = 0,
                            s = 0;
                        return e = t.event.fix(n), e.type = "mousewheel", n.wheelDelta && (r = n.wheelDelta / 120), n.detail && (r = -n.detail / 3), s = r, n.axis !== i && n.axis === n.HORIZONTAL_AXIS && (s = 0, a = -1 * r), n.wheelDeltaY !== i && (s = n.wheelDeltaY / 120), n.wheelDeltaX !== i && (a = -1 * n.wheelDeltaX / 120), o.unshift(e, r, a, s), (t.event.dispatch || t.event.handle).apply(this, o)
                    }
                    var n = ["DOMMouseScroll", "mousewheel"];
                    if (t.event.fixHooks)
                        for (var o = n.length; o;) t.event.fixHooks[n[--o]] = t.event.mouseHooks;
                    t.event.special.mousewheel = {
                        setup: function () {
                            if (this.addEventListener)
                                for (var t = n.length; t;) this.addEventListener(n[--t], e, !1);
                            else this.onmousewheel = e
                        },
                        teardown: function () {
                            if (this.removeEventListener)
                                for (var t = n.length; t;) this.removeEventListener(n[--t], e, !1);
                            else this.onmousewheel = null
                        }
                    }, t.fn.extend({
                        mousewheel: function (t) {
                            return t ? this.bind("mousewheel", t) : this.trigger("mousewheel")
                        },
                        unmousewheel: function (t) {
                            return this.unbind("mousewheel", t)
                        }
                    })
                }(e), s.fn.prevent_scroll = function () {
                    this.bind("mousewheel", function (t, e) {
                        return this.scrollHeight == this.clientHeight ? !0 : this.scrollTop <= 0 && e > 0 ? !1 : this.scrollTop + this.offsetHeight >= this.scrollHeight && 0 > e ? !1 : !0
                    })
                }, s.last = function (t) {
                    return t[t.length - 1]
                }, s.select = function (t, e) {
                    var i = [];
                    return s.each(t, function (t) {
                        e.call(this, t) && i.push(this)
                    }), i
                }, s.arraysEqual = function (t, e) {
                    return !(e > t || t > e)
                }, s.fn.height_defined = function () {
                    this.addClass("default_height_check");
                    var t = 1337 != Math.round(this.outerHeight(!0));
                    return this.removeClass("default_height_check"), t
                }, s.getParameterByName = function (t) {
                    var e = RegExp("[?&]" + t + "=([^&]*)").exec(window.location.search);
                    return e && decodeURIComponent(e[1].replace(/\+/g, " "))
                }, s.parse_hash = function (t) {
                    var e = t.substr(1).split("&"),
                        i = {};
                    return s.each(e, function () {
                        var t = this.split("=");
                        i[t[0]] = t[1]
                    }), i
                }, s.fn.placeholder = function () {
                    return s(this).each(function () {
                        s(this).addClass("ts_placeholder").data("original-value", s(this).val()).focus(function () {
                            var t = s(this);
                            t.val() == t.data("original-value") && (t.removeClass("ts_placeholder"), t.val(""))
                        }).blur(function () {
                            var t = s(this);
                            "" == s.trim(t.val()) && (t.addClass("ts_placeholder"), t.val(t.data("original-value")))
                        })
                    })
                };
                var h = {
                    new_window: function (t, e, n) {
                        s.isFunction(e) && (n = e, e = i);
                        var o = {
                            height: 500,
                            width: 950
                        };
                        s.extend(o, e);
                        var r = window.screenLeft || window.screenX || 0;
                        r += (s(window).width() - o.width) / 2;
                        var a = window.screenTop || window.screenY || 0;
                        a += (s(window).height() - o.height) / 2;
                        var l = "width=" + o.width + "," + "height=" + o.height + "," + "left=" + r + ",top=" + a + "," + "scrollbars=no,toolbar=no,location=no,menubar=no",
                            c = window.open(t, "turnsocial", l);
                        if (s.isFunction(n)) var d = setInterval(function () {
                            c.closed && (clearInterval(d), n())
                        }, 100);
                        return c
                    },
                    new_frame: function () {
                        var t = s("<iframe />", {
                            name: "ts_frame",
                            style: "display: none !important",
                            width: 0,
                            height: 0
                        });
                        return s("#ts").append(t), t
                    },
                    xd_frame: function (t) {
                        var e = h.new_frame(),
                            i = e[0].contentWindow || e[0].documentWindow;
                        return h.xd_listener(i, function (i) {
                            e.remove(), t(i)
                        }), e
                    },
                    xd_popup: function (t, e) {
                        s.isFunction(t) && (e = t, t = "");
                        var i = !1,
                            n = h.new_window(t, function () {
                                i || e()
                            });
                        return h.xd_listener(n, function (t) {
                            e(t), i = !0, n.close()
                        }), n
                    },
                    xd_listener: function (t, e) {
                        try {
                            return t.postMessage("", "*"), s(window).bind("message", function (t) {
                                var i = t.originalEvent.data;
                                i = s.parse_hash(i), e(i)
                            }), void 0
                        } catch (i) {}
                        var n = setInterval(function () {
                            try {
                                if ("about:blank" !== t.location.toString()) {
                                    var i = t.location.hash;
                                    if ("#loading" == i) return;
                                    clearInterval(n);
                                    var o = s.parse_hash(i);
                                    e(o)
                                }
                            } catch (r) {}
                        }, 100)
                    },
                    post_into: function (t, e, n) {
                        var o = s("<form />", {
                            method: "post",
                            target: n.name || n.attr("name") || n.attr("id"),
                            action: t
                        });
                        s.each(e, function (t, e) {
                            if (e != i) {
                                var n = s("<input />", {
                                    type: "hidden",
                                    name: t,
                                    value: e
                                });
                                o.append(n)
                            }
                        }), s("#ts").append(o), o.submit()
                    }
                }, f = {
                        set: function (t, e, i, n) {
                            var o = "";
                            if (i) {
                                var r = new Date;
                                r.setDate(r.getDate() + i), o = "; expires=" + r.toGMTString()
                            }
                            domain_str = "", n && ("." != n[0] && (n = "." + n), domain_str = "; domain=" + n), document.cookie = t + "=" + encodeURIComponent(e) + domain_str + "; path=/" + o
                        },
                        get: function (t) {
                            var e = document.cookie.split(";"),
                                i = s.map(e, function (e) {
                                    var i = e.split("=");
                                    return s.trim(i[0]) == t ? decodeURIComponent(s.trim(i[1])) : void 0
                                });
                            return i[0]
                        },
                        erase: function (t) {
                            this.set(t, "", -1)
                        }
                    }, A = {
                        parse: s.parseJSON
                    };
                ! function () {
                    var t, e, i, n = function (t) {
                            return 10 > t ? "0" + t : t
                        }, o = /[\\\"\x00-\x1f\x7f-\x9f\u00ad\u0600-\u0604\u070f\u17b4\u17b5\u200c-\u200f\u2028-\u202f\u2060-\u206f\ufeff\ufff0-\uffff]/g,
                        r = {
                            "\b": "\\b",
                            "    ": "\\t",
                            "\n": "\\n",
                            "\f": "\\f",
                            "\r": "\\r",
                            '"': '\\"',
                            "\\": "\\\\"
                        }, a = function (t) {
                            return o.lastIndex = 0, o.test(t) ? '"' + t.replace(o, function (t) {
                                var e = r[t];
                                return "string" == typeof e ? e : "\\u" + ("0000" + t.charCodeAt(0).toString(16)).slice(-4)
                            }) + '"' : '"' + t + '"'
                        }, s = function (o, r) {
                            var l, c, d, p, u, h = t,
                                f = r[o];
                            switch ("function" == typeof i && (f = i.call(r, o, f)), "object" == typeof f && Object.prototype.toString.apply(f)) {
                            case "[object Boolean]":
                            case "[object Number]":
                            case "[object String]":
                                f = f.valueOf()
                            }
                            switch (typeof f) {
                            case "string":
                                return a(f);
                            case "number":
                                return isFinite(f) ? String(f) : "null";
                            case "boolean":
                            case "null":
                                return String(f);
                            case "object":
                                if (!f) return "null";
                                if (t += e, u = [], "[object Date]" === Object.prototype.toString.apply(f)) return isFinite(f.valueOf()) ? f.getUTCFullYear() + "-" + n(f.getUTCMonth() + 1) + "-" + n(f.getUTCDate()) + "T" + n(f.getUTCHours()) + ":" + n(f.getUTCMinutes()) + ":" + n(f.getUTCSeconds()) + "Z" : null;
                                if ("[object Array]" === Object.prototype.toString.apply(f)) {
                                    for (p = f.length, l = 0; p > l; l += 1) u[l] = s(l, f) || "null";
                                    return d = 0 === u.length ? "[]" : t ? "[\n" + t + u.join(",\n" + t) + "\n" + h + "]" : "[" + u.join(",") + "]", t = h, d
                                }
                                if (i && "object" == typeof i)
                                    for (p = i.length, l = 0; p > l; l += 1) "string" == typeof i[l] && (c = i[l], d = s(c, f), d && u.push(a(c) + (t ? ": " : ":") + d));
                                else
                                    for (c in f) Object.prototype.hasOwnProperty.call(f, c) && (d = s(c, f), d && u.push(a(c) + (t ? ": " : ":") + d));
                                return d = 0 === u.length ? "{}" : t ? "{\n" + t + u.join(",\n" + t) + "\n" + h + "}" : "{" + u.join(",") + "}", t = h, d
                            }
                        };
                    A.stringify = function (n, o, r) {
                        var a;
                        if (t = "", e = "", "number" == typeof r)
                            for (a = 0; r > a; a += 1) e += " ";
                        else "string" == typeof r && (e = r); if (i = o, o && "function" != typeof o && ("object" != typeof o || "number" != typeof o.length)) throw new Error("JSON.stringify");
                        return s("", {
                            "": n
                        })
                    }
                }();
                var g = A.parse(f.get("turnsocial") || "{}");
                g.save = function () {
                    f.set("turnsocial", A.stringify(g), 3660)
                }, "false" === f.get("turnsocial_visible") && (g.visible = !1, g.save()), f.erase("turnsocial_visible"), f.erase("turnsocial_unique");
                var m = {
                    linkify: function (t) {
                        var e = t.replace(/[A-Za-z]+:\/\/[A-Za-z0-9-_]+\.[A-Za-z0-9-_:%&\?\/.=]+/g, function (t) {
                            var e = s("<a />", {
                                href: t,
                                text: t
                            });
                            return s("<div />").append(e).html()
                        });
                        return e = e.replace(/(^|\s)@(\w+)/g, '$1<a href="http://twitter.com/$2">@$2</a>'), e.replace(/(^|\s)#(\w+)/g, '$1<a href="http://twitter.com/search?q=%23$2">#$2</a>')
                    },
                    truncate: function (t, e) {
                        return t.length < e ? t : t.substring(0, e - 3) + "..."
                    },
                    striptags: function (t) {
                        return t.replace(/<\/?[^>]+>/gi, "")
                    },
                    capitalize: function (t) {
                        return t.replace(/\S+/g, function (t) {
                            return t.charAt(0).toUpperCase() + t.slice(1).toLowerCase()
                        })
                    },
                    format_phone: function (t) {
                        return 10 != t.length ? t : "(" + t.substring(0, 3) + ") " + t.substring(3, 6) + "-" + t.substring(6, 10)
                    },
                    pluralize: function (t, e, i) {
                        return 1 == t ? e : i
                    }
                }, w = {
                        relative_time: function (t, e) {
                            var i = new Date - t;
                            if (e = parseInt(e, 10) || 0, e >= i) return "Just now";
                            var n = null,
                                o = {
                                    millisecond: 1,
                                    second: 1e3,
                                    minute: 60,
                                    hour: 60,
                                    day: 24,
                                    month: 30,
                                    year: 12
                                };
                            for (var r in o) {
                                if (i < o[r]) break;
                                n = r, i /= o[r]
                            }
                            return i = Math.floor(i), 1 !== i && (n += "s"), [i, n, "ago"].join(" ")
                        }
                    }, v = function (t) {
                        var e = [],
                            i = 5,
                            n = 200,
                            o = !0,
                            r = s("<div />", {
                                "class": "ts_spinner"
                            });
                        t.append(r);
                        for (var a = 0; i > a; a++) {
                            var l = s("<div />", {
                                "class": "ts_spinner_segment"
                            });
                            r.append(l), l.css({
                                left: 2 * l.width() * a,
                                opacity: 0
                            }), e.push(l)
                        }
                        var c = 2 * i * l.width();
                        r.css({
                            width: c,
                            "margin-left": -c / 2,
                            "margin-top": -r.height() / 2
                        });
                        var d = 1,
                            p = function (t) {
                                o && (e[t].queue("fx").length > 0 && e[t].stop(!0, !0), e[t].css({
                                    opacity: 1
                                }), e[t].animate({
                                    opacity: 0
                                }, 200 * i), t += d, (0 == t || t == i - 1) && (d *= -1), setTimeout(function () {
                                    p(t)
                                }, n))
                            };
                        return p(0), {
                            stop: function () {
                                o = !1, r.remove()
                            }
                        }
                    };
                ! function (t, e) {
                    function i(t, e, i) {
                        return [parseFloat(t[0]) * (h.test(t[0]) ? e / 100 : 1), parseFloat(t[1]) * (h.test(t[1]) ? i / 100 : 1)]
                    }

                    function n(e, i) {
                        return parseInt(t.css(e, i), 10) || 0
                    }

                    function o(e) {
                        var i = e[0];
                        return 9 === i.nodeType ? {
                            width: e.width(),
                            height: e.height(),
                            offset: {
                                top: 0,
                                left: 0
                            }
                        } : t.isWindow(i) ? {
                            width: e.width(),
                            height: e.height(),
                            offset: {
                                top: e.scrollTop(),
                                left: e.scrollLeft()
                            }
                        } : i.preventDefault ? {
                            width: 0,
                            height: 0,
                            offset: {
                                top: i.pageY,
                                left: i.pageX
                            }
                        } : {
                            width: e.outerWidth(),
                            height: e.outerHeight(),
                            offset: e.offset()
                        }
                    }
                    t.ui = t.ui || {};
                    var r, a = Math.max,
                        s = Math.abs,
                        l = Math.round,
                        c = /left|center|right/,
                        d = /top|center|bottom/,
                        p = /[\+\-]\d+(\.[\d]+)?%?/,
                        u = /^\w+/,
                        h = /%$/,
                        f = t.fn.position;
                    t.position = {
                        scrollbarWidth: function () {
                            if (r !== e) return r;
                            var i, n, o = t("<div style='display:block;width:50px;height:50px;overflow:hidden;'><div style='height:100px;width:auto;'></div></div>"),
                                a = o.children()[0];
                            return t("body").append(o), i = a.offsetWidth, o.css("overflow", "scroll"), n = a.offsetWidth, i === n && (n = o[0].clientWidth), o.remove(), r = i - n
                        },
                        getScrollInfo: function (e) {
                            var i = e.isWindow ? "" : e.element.css("overflow-x"),
                                n = e.isWindow ? "" : e.element.css("overflow-y"),
                                o = "scroll" === i || "auto" === i && e.width < e.element[0].scrollWidth,
                                r = "scroll" === n || "auto" === n && e.height < e.element[0].scrollHeight;
                            return {
                                width: r ? t.position.scrollbarWidth() : 0,
                                height: o ? t.position.scrollbarWidth() : 0
                            }
                        },
                        getWithinInfo: function (e) {
                            var i = t(e || window),
                                n = t.isWindow(i[0]);
                            return {
                                element: i,
                                isWindow: n,
                                offset: i.offset() || {
                                    left: 0,
                                    top: 0
                                },
                                scrollLeft: i.scrollLeft(),
                                scrollTop: i.scrollTop(),
                                width: n ? i.width() : i.outerWidth(),
                                height: n ? i.height() : i.outerHeight()
                            }
                        }
                    }, t.fn.position = function (e) {
                        if (!e || !e.of) return f.apply(this, arguments);
                        e = t.extend({}, e);
                        var r, h, A, g, m, w, v = t(e.of),
                            b = t.position.getWithinInfo(e.within),
                            _ = t.position.getScrollInfo(b),
                            y = (e.collision || "flip").split(" "),
                            x = {};
                        return w = o(v), v[0].preventDefault && (e.at = "left top"), h = w.width, A = w.height, g = w.offset, m = t.extend({}, g), t.each(["my", "at"], function () {
                            var t, i, n = (e[this] || "").split(" ");
                            1 === n.length && (n = c.test(n[0]) ? n.concat(["center"]) : d.test(n[0]) ? ["center"].concat(n) : ["center", "center"]), n[0] = c.test(n[0]) ? n[0] : "center", n[1] = d.test(n[1]) ? n[1] : "center", t = p.exec(n[0]), i = p.exec(n[1]), x[this] = [t ? t[0] : 0, i ? i[0] : 0], e[this] = [u.exec(n[0])[0], u.exec(n[1])[0]]
                        }), 1 === y.length && (y[1] = y[0]), "right" === e.at[0] ? m.left += h : "center" === e.at[0] && (m.left += h / 2), "bottom" === e.at[1] ? m.top += A : "center" === e.at[1] && (m.top += A / 2), r = i(x.at, h, A), m.left += r[0], m.top += r[1], this.each(function () {
                            var o, c, d = t(this),
                                p = d.outerWidth(),
                                u = d.outerHeight(),
                                f = n(this, "marginLeft"),
                                w = n(this, "marginTop"),
                                k = p + f + n(this, "marginRight") + _.width,
                                I = u + w + n(this, "marginBottom") + _.height,
                                C = t.extend({}, m),
                                S = i(x.my, d.outerWidth(), d.outerHeight());
                            "right" === e.my[0] ? C.left -= p : "center" === e.my[0] && (C.left -= p / 2), "bottom" === e.my[1] ? C.top -= u : "center" === e.my[1] && (C.top -= u / 2), C.left += S[0], C.top += S[1], t.support.offsetFractions || (C.left = l(C.left), C.top = l(C.top)), o = {
                                marginLeft: f,
                                marginTop: w
                            }, t.each(["left", "top"], function (i, n) {
                                t.ui.position[y[i]] && t.ui.position[y[i]][n](C, {
                                    targetWidth: h,
                                    targetHeight: A,
                                    elemWidth: p,
                                    elemHeight: u,
                                    collisionPosition: o,
                                    collisionWidth: k,
                                    collisionHeight: I,
                                    offset: [r[0] + S[0], r[1] + S[1]],
                                    my: e.my,
                                    at: e.at,
                                    within: b,
                                    elem: d
                                })
                            }), e.using && (c = function (t) {
                                var i = g.left - C.left,
                                    n = i + h - p,
                                    o = g.top - C.top,
                                    r = o + A - u,
                                    l = {
                                        target: {
                                            element: v,
                                            left: g.left,
                                            top: g.top,
                                            width: h,
                                            height: A
                                        },
                                        element: {
                                            element: d,
                                            left: C.left,
                                            top: C.top,
                                            width: p,
                                            height: u
                                        },
                                        horizontal: 0 > n ? "left" : i > 0 ? "right" : "center",
                                        vertical: 0 > r ? "top" : o > 0 ? "bottom" : "middle"
                                    };
                                p > h && s(i + n) < h && (l.horizontal = "center"), u > A && s(o + r) < A && (l.vertical = "middle"), l.important = a(s(i), s(n)) > a(s(o), s(r)) ? "horizontal" : "vertical", e.using.call(this, t, l)
                            }), d.offset(t.extend(C, {
                                using: c
                            }))
                        })
                    }, t.ui.position = {
                        fit: {
                            left: function (t, e) {
                                var i, n = e.within,
                                    o = n.isWindow ? n.scrollLeft : n.offset.left,
                                    r = n.width,
                                    s = t.left - e.collisionPosition.marginLeft,
                                    l = o - s,
                                    c = s + e.collisionWidth - r - o;
                                e.collisionWidth > r ? l > 0 && 0 >= c ? (i = t.left + l + e.collisionWidth - r - o, t.left += l - i) : t.left = c > 0 && 0 >= l ? o : l > c ? o + r - e.collisionWidth : o : l > 0 ? t.left += l : c > 0 ? t.left -= c : t.left = a(t.left - s, t.left)
                            },
                            top: function (t, e) {
                                var i, n = e.within,
                                    o = n.isWindow ? n.scrollTop : n.offset.top,
                                    r = e.within.height,
                                    s = t.top - e.collisionPosition.marginTop,
                                    l = o - s,
                                    c = s + e.collisionHeight - r - o;
                                e.collisionHeight > r ? l > 0 && 0 >= c ? (i = t.top + l + e.collisionHeight - r - o, t.top += l - i) : t.top = c > 0 && 0 >= l ? o : l > c ? o + r - e.collisionHeight : o : l > 0 ? t.top += l : c > 0 ? t.top -= c : t.top = a(t.top - s, t.top)
                            }
                        },
                        flip: {
                            left: function (t, e) {
                                var i, n, o = e.within,
                                    r = o.offset.left + o.scrollLeft,
                                    a = o.width,
                                    l = o.isWindow ? o.scrollLeft : o.offset.left,
                                    c = t.left - e.collisionPosition.marginLeft,
                                    d = c - l,
                                    p = c + e.collisionWidth - a - l,
                                    u = "left" === e.my[0] ? -e.elemWidth : "right" === e.my[0] ? e.elemWidth : 0,
                                    h = "left" === e.at[0] ? e.targetWidth : "right" === e.at[0] ? -e.targetWidth : 0,
                                    f = -2 * e.offset[0];
                                0 > d ? (i = t.left + u + h + f + e.collisionWidth - a - r, (0 > i || i < s(d)) && (t.left += u + h + f)) : p > 0 && (n = t.left - e.collisionPosition.marginLeft + u + h + f - l, (n > 0 || s(n) < p) && (t.left += u + h + f))
                            },
                            top: function (t, e) {
                                var i, n, o = e.within,
                                    r = o.offset.top + o.scrollTop,
                                    a = o.height,
                                    l = o.isWindow ? o.scrollTop : o.offset.top,
                                    c = t.top - e.collisionPosition.marginTop,
                                    d = c - l,
                                    p = c + e.collisionHeight - a - l,
                                    u = "top" === e.my[1],
                                    h = u ? -e.elemHeight : "bottom" === e.my[1] ? e.elemHeight : 0,
                                    f = "top" === e.at[1] ? e.targetHeight : "bottom" === e.at[1] ? -e.targetHeight : 0,
                                    A = -2 * e.offset[1];
                                0 > d ? (n = t.top + h + f + A + e.collisionHeight - a - r, t.top + h + f + A > d && (0 > n || n < s(d)) && (t.top += h + f + A)) : p > 0 && (i = t.top - e.collisionPosition.marginTop + h + f + A - l, t.top + h + f + A > p && (i > 0 || s(i) < p) && (t.top += h + f + A))
                            }
                        },
                        flipfit: {
                            left: function () {
                                t.ui.position.flip.left.apply(this, arguments), t.ui.position.fit.left.apply(this, arguments)
                            },
                            top: function () {
                                t.ui.position.flip.top.apply(this, arguments), t.ui.position.fit.top.apply(this, arguments)
                            }
                        }
                    },
                    function () {
                        var e, i, n, o, r, a = document.getElementsByTagName("body")[0],
                            s = document.createElement("div");
                        e = document.createElement(a ? "div" : "body"), n = {
                            visibility: "hidden",
                            width: 0,
                            height: 0,
                            border: 0,
                            margin: 0,
                            background: "none"
                        }, a && t.extend(n, {
                            position: "absolute",
                            left: "-1000px",
                            top: "-1000px"
                        });
                        for (r in n) e.style[r] = n[r];
                        e.appendChild(s), i = a || document.documentElement, i.insertBefore(e, i.firstChild), s.style.cssText = "position: absolute; left: 10.7432222px;", o = t(s).offset().left, t.support.offsetFractions = o > 10 && 11 > o, e.innerHTML = "", i.removeChild(e)
                    }()
                }(e);
                var b = {
                    share: "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABcAAAASCAYAAACw50UTAAAAAXNSR0IB2cksfwAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAACXBIWXMAAAsTAAALEwEAmpwYAAABcklEQVQ4y63UzStEURgG8EtjJCULRGooO4awsmGhlIWyI/8EmykJxUIhX0PyFdnJmkSysbBRsrAiZCdm7HwsmPG8ek6djnNw71j8unfOx9Pc977nerGFcy+gMtiCOtcaL4PwYriHR2j/7/BCuIU0vECvLbwaGqDe0AqlltBslqQRrhmuLEGBHr5pLFDOoJILc6AJpuGEpUg7HEFEha9z8Anu4AEOoYrBUdiB9x8CTVKuTtm8xoEpCLGW+QzugKSPUN2BBKzyx6RRW3kPiYDB21AhISscmNCC5Qn2LJs+WDZ5kRfwbMy/wSj3f9V8mRPjWngLpDj+CsfQB21Qzo6Q8l1qwVK+LrMVFzk5pk30c2wXmiHL0pJ5cMV1p2zfb30+xwUj2sQGzKrHc8iFG3ZSkeuE2sJLfglW/7wHwryfgZq/hPsR4gdMMmpd4QMBw8PaNybqCt+HGAz5MAjDPN3W8HjAg2JK2cK7eUrjGZjnNaKHfwJNLaXRCnZQdwAAAABJRU5ErkJggg==",
                    facebook_fan: "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABcAAAAXCAYAAADgKtSgAAAAAXNSR0IB2cksfwAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAACXBIWXMAAAsTAAALEwEAmpwYAAAE4klEQVRIDQXBTailZR0A8N//eZ7znnPunfs9H+qkkx+FSpIguBBaBG7atIig2kQtFCOirW2CiDJsUQQtM4latAqCUMigViWSg1DTRKWmpjPOnTt3Zu695+M97/P0+8XTTz0tJqcv7Dzw5PO75+75bKarrTUAAAAIIaJpDWiNUkqeL1YH+/999Xv9zXd/2h+9tyjRbd07OfPI1/bOfPRz651ysljRAAAACAy1WvaDAWpTGxtr1dap8e7yzke/eTC7dZn3Xird3oNfOvORh788mZby/rVDs3kVAQAACFZDteyr9UmxtTEynWRwcGth0S9t7+7dc3zzvmeWNy6/Wsr41CdLyRvXD4/dOllIEgEAaESwGqrV0Dxy/7YnHjljb7Mz7pIc4fevXfGni1dcGE3l0fR+KZ8ubVjl2WxuWTt1NWhRAQAA4WSx8tCFLV988oKdjQ4AnN7qLJe9k9nKatlHay2X1lptTRuGql+thAARIdAiRND3TeCxB3ftbHQArlyfuXa48K93b2mtCpWm1lpb6fveatVrkUVKtEajNVprJIYhfHgwszYpdk51AD7Yn/nJry/5+1uHdjY6G+sjVMvFktaU/f0DR/0HWlnX99V42imjkZIzkbTGqMseOL9pe6OzPi0AjucrJYULd6xbLHrX92+an8wdfnjFzjAos5O5ebvlaHHk5GRpPJnoJp1R6ZRuZLlq7j2/7Suff9hdZ9asTQuAu8+u+8YXHpJz8uJv3vCr3/7Tned21PncdhdKLlmUEcuwqkt13psvBmIhJMeLam+9uPuONVunxgBg3CVnd6dgZ3OsXzU5F6kUUESWUlZKNhp1IjIRIrIWoWvV8bz642vvO3/ulPvPb9rZGoPD2wuX37qhtuo//zs2nkzkUWfoMygEEUhEJhW/eO4z7jyz7ls//rOLl/cdHvW+/8Ibtjcmvvv1xzy+dQa8/f5tz/3sdVf3Z0oOk8lYjmxoCSGFEJKILGQRWWvUikgiZU3R98liSa0AtMaiT+ZLKiJlKSWRApSIJCKLlEROIoWhMtRGJJGyFFnuwqgrQgAISSlFHhU5hxxVS5mUaBQRRPLsU4/7xMf2AKxq8+1nHgPw1e/8xWw2kAJAE1LKUhSCFoQkWqaFIkIItbEaAAAASLJIgQAQKUQqImURTUQTKYkUolK0FC2F539+0fHxUkrFj579lLO7Uz944W8uvXlLytnRbLB1qhMCAJBFZCk1oWmyJkcjUpPSqJRUcjHUUIWhNkNtCGQUYiSlka4rALqSpJSQ1JY0STcqUi4lRURpq9m1YWj96e216XzRm/cMldXQtBZEEEmK0GSHRys3bvfgxtFKE5owaM5uTYy74mhY3ogYTsredP/lq4fvfLyWzU+fv+O027PeD1+8ROqkKE7vbkqpGCQlF6/8de7iv3tadXC4MJ2uu+vcyHTSrE86V/cP6sbq7ZcillfL3vrsldpf7q8fRInt+x4d5dF6KCI1kQYhSTHociYNLr81t1yutDooabA2Zn0ySFoc7F+7Nj35x++20zu/xEkZhna0OV68PKmXPjy59c4TNUancy4CIhACIhFhS1CrpqGJBXU1pKG1YTdmb651N/9Qh/7dJhRoyjCKxWvb5eR16ujw5u0YahUAGtAAAbSgDs3mqXXduKujbrycL1trAvwfbmUtSDZqju0AAAAASUVORK5CYII=",
                    twitter_user: "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABcAAAAXCAYAAADgKtSgAAAAAXNSR0IB2cksfwAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAACXBIWXMAAAsTAAALEwEAmpwYAAAE/klEQVRIDQXBz6tcdxnH8ffneb7nzMydTG5ufic1pteo1AQlgUIXBUGK4KK40C7ElTtBcCEq/gtuRRB37gqC+AvqxqW0Ck3RWmIbDakmJt70Tqb3TmbOnDnnfL+Pr5e++/0f0l658dqJl77849l051qUXIQiJEoEhjAFAAAAAAEAAASyQLGcf/Tn9t0//WAyf/CX0ajGYvfcDf/cSz86e3rv2kQByIYo3uTibQ7f5OJtDg/hEo5wCTdwhAMOoR3H9i5eflnP3/he1OOLBlWKqy986/z+tRe7dsX/mo4uQxDszyquTis2Q+GDZz0Hq2DiQoIAiCAAgBwwsuDCLHH20y98dXH44K/twf03Uh5NbknBk3XLKoMBX7ww4dXnTnBu7JQCd463/PLBio+2mVpCAAAEAQhohsK82XJqnMa5Ht9ah+5Z5LDNkOkDulzYn9V87cqMS5PE0yIaE7dOj/nS+R3aHBx1hWdDYTUUtiUIIAABXQRNnyMiJCklEUUEQwQZ2J86Z0bOQYb5ECAY1+L6bsW1aWLZF0YmBuDpNvNsKExdZEACM1BEiYhIfQQFcBPJIZkYApqAdQEBywyXdxLf+cwufQEXZODusuO3j1ccbYOJC5OIgKEEKkE63LSsV2uadksfRp+DAIaArkASzIdASezuVAjYAhbwyrRiksTP/7Vkse2oh4Ki0LRbTuRManNms+mYrxqaARbnaiKCNsQ6gjHwZIDDDFVAAIOgLfCpWtzcG3PSF7xzuObsTs3UDUpmEoXk5siNQHRk+hKExDrDUQ9jgwHoSyECApCgKbCDcWUCyaErgUvUSRR3zIxkEu5O7U4dIrlTAtocrHMwBEwFUxMABcgB5yr4/I543PTcX2dOjCpSctwMEAKSAAkk4TJMIoB2gHUPvcH1qbg+MSQoQAEc+M+642f3nnLYZqaVI4QkZACQTMJMuAk34QZE0JZglYNRgSQxchAAADAUeHO+4e3FlsqNZIG5MIkcAkQyCcNwM8ygMiMk2lLY5EIYPNiKkRUiIIAhYNfFNz45wwW/+PCYEgU3w00UCQFJAnPDTchgOQQKqBHNEJiL28vC20sIACAHBIVXz1a89omTvLVoeffjDS4hGRggMBCGqExI8I9nPUddz80TwhUcdIVFn3naZxZ9ZtFnlkPmYVv42yrjgkvjRAFMhkkYQgiTSRKYnJkn7jeZXz9quFrDNy/UfHZi7CZxJokzSZxJYpbE/sR4eeash8LDTWbiDgYSAAKUZO6VG5KoEzjG7w4aRsn4+uUdvn2pYpkhAACAAowFIwWv/7fh301h5IZj1G7appTkZknt+klKFecnicebgWkl2iJef9RwZz3w4qma87XjgggIgQVsSvDOcceb8y2VYCRxelJRSmS1zUfebRdp99E//zA/+MJXzj935eTzk5Y2Q+3GIPG4iDeOjLELNyFBCRFRGErQ5cTFk4mKQmWiVBWLu3fu7j18//eT1dF7/srNG4/axSGbyan9uk5Tz4O89DEuOWYxxJgcVR5iHDmqkiMNfXjpoxr6mJY+qtwHQ8/QNtvVvfc/mN7+409OPX34G4fjVIj57ofv/bQsD//eTU9dN/dxQBlQZIFJSDBIgCACAEWQIygEQy5Syc/2jg9v16uP38JTFxIpEBkOp8dPfjWZP6rbrvPVukECEAABQAAAACBEACbYm81CybM89YNXmADg/2LQmg1NgPSuAAAAAElFTkSuQmCC",
                    twitter_search: "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABcAAAAXCAYAAADgKtSgAAAAAXNSR0IB2cksfwAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAACXBIWXMAAAsTAAALEwEAmpwYAAAFWElEQVRIx12WTWxcVxXHf+fe++bNhyczTuwkdhTFrl2IE6m1pUotihIRBaQiyndX7YJ2hYSEKALEspXYwIpW7FiFTSUkvlJRVKiQKyIIEkFNWiVOG1NiGzeOZzzxjOfjzbx372Exjt1wpSNd3cU95/zO/5x75Tvf/yHJ8dPPjjz5+Z+US8UZDT4IoipCUMUgGFH+f+lDezGKaKu+eSW5fvkHhfrqP+I4h9PK+Gk79+SPxg6OzphBQhcxmQb6QUBBUKxA7AQDxFZYGI35dDkCGXpZaqXcaqVij06e2Wie/p62Nr9rCFtOT5x84fD0zBO3aw0UZboc8UgpRy8L3NpJaQ6UghUkgzPjeZ4/5mHlF+jypb3Ipya+whdmXuDNrYgrsye/3KitvptsfPSm83FhQUTJNHDuSIFnjo0wnreEADeafX612maz76k6w/PHPPrX89C89jCi2juw8ku+eG6RGy2Tr+XyCx2VZaNeTS/zTJdzfP14mYmCYysIXSMsHMxz/nCRxCvzo3lYubh3sTz2M+TsIjL3ytBD8xosv8ZCJVJVFRFxTtAgKNMly6HYsuGhnikI5HPCqUrETMkxHhtoNvfDTZtQmqJ+4CxjUQWiKlTnubk5QFSDqqpJVQmAM0Km0FXoBOh6aHmYLDq+/WiFx6sxnPjmPoqlV9C3pjm0OIs2r0NxisvpSZqpkgUlBMXUeglr7Q6pVxTIFAYBvA4zaAShUowYLTr6xSnkwrsw+dX9DLp3YOUievk8Z2s/5fEDVupJn573mMR7tnoDGkmCqpIodFTpq3IvU272lWsd5cOecj8Doioy9zLypfv7zKPqMJvlV7lwtEQ/eLwGnDUWsYY0KCpCx8N2CnkDGZCGgCo8VTIcuf4iunJx6ODcIrfznyGdfIq5dBuWX4V0mxFncNZijMEZEay1OAtBIfFKxyuZQkmgZASAu6nyyNzL6Me/h3Qb/csCs+OfhcH2vjRnX+Ktu20MggBOABEwIiiQZNBJITVwqiScKhhEIACpTBGdW0SvfG3IuvbOPvvZl/jD2I/50922ihkeOSOCMYI1gCpJUNpeiQM4EWI77PIHKxyYp/u5fzMyWIXOneFhdZ5Lm4Y3Pt6hOQigAsju5RgiAypCEgI9H1ADq30hNkPmD5RUscJYBL9pHOJyrYgSuL3Uop0FRuKIshWCPMAiYKyhlXlEIYfQzRRjhautwD9b+xPQKyiBZ8Yinj46wp83u1y/n+xlZUUQMWAAAQOCQbi5k7I9SJkfEawoG4NAI/VspZ7GrrUyz1oSuNb2WIGJvCPAnhkxDEkIgmDEiIjAR13Pb9e7nMjBc0dyfKpgqDjh0Ces7ITpguFM2dLJAms9T8HaPcMMxTGMG3FirI2sIbaGSxtdYmf4xmSRb01EtPzDj0IA8gKxKK//t8udbiC2Zh8Lhpw10nfOiTXGSdK551xEKRKSILy+3uVGJ+OJao7DOYsVhgUVMAq9oPyrOeBv9T6RQCz7WjpYiAhBvSTdTTvoN1xl/cM/1jcee3ri2PEDOkhIPOyo4e1tpRc81hjy1mCNDPWugqrh6GiOgQ/kgIhAZIQQRTQ+uPHB6NrSG4X29vv2wvzp9aRRo1eoTudyrmR9Jjakmg9ey5ppHq+RzzSvXqPg1WWp2pBqlKVaCqlGPlWylCzp9tvLS7dKV99+rbq19jsLTRfQeuU/7/88tGrvDUrVU8bavELIEPW7nSsCmQwbAx1WQVTxqgSUzAeR4HdGm7Wrufb9v2PdQEVwiuChVmre+3Whvp5LBgPb7nR3qy6feOkf/gEIw3FhBEbLZRVnvViXZjZidxzxPyefrTNTLnCFAAAAAElFTkSuQmCC",
                    turnsocial: "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABkAAAAZCAYAAADE6YVjAAAE50lEQVR42q1Wa0wcVRgduo/Z92NmZ/YJs0/2Acu6u7AIVaKF7AIiSUVMSBtAqqhNaYhN1GoM9fHDCFGKpUaDUfFZEmPCD6r1AfKjNA2NbbSlGqOFJq1JEwO12IUF1nNJljQWsJTeZJKZe7/5zv3OPeeboah1Rmtrq2Rr2dZHLFbrEZZlz8oV8ilaJruo0+v+0LPsiMPh6CkpKYl1dHRsoW5nDA0N0Xa7/QuxRDKNa0GuUCz5/P7Lfr9/LBAITKo06kWRWLyItatms/lYb2+v6ZaTp9PpLKfT+bRao5nRaDWTPM+/fB/GwMCA9MY4PIsSDyRiANivZ5gJmVw+ZzKZXurs7FSuC4BcYqPR+J5ILJpHFV/+7ws3bCwcDh+USCVzAB1FHtWawUaz+R3saD47O/tRPIo2yHBWKBJ6CNXPWiyWH1bdYG5u7m6RRJyyCbbHqE2MSCSyXUJLk6DuwE2Laq3mEko9Wl9fL6I2N7YUFBS8CUaS3d3dxuUZIr9gMHhIqVL+2dbWxlF3YJAz0jP6c6D/2LK8y8vLSyDDKyaLpScTVFVVRQuCYA5Ho8+6XK5vBbuQ5I18OicnJ5WXn3/GYrO8RfyBUPE65/ucWCq5GovFcilo/xAe5tw+94NksbS0NA75nuB47qI1O/trrKXBcZqWyxYC+YE2GNCbIwjnZAp5CvLuWgskkUhEiL8QH6c4nv8Rkk2jLIvX6y0ElzM6vf5sNBrVckbj9wSAXAql8rTNZpMXFhZ6YcQFAq7Raj9bC4TQBMpSMO9uHLh2imHZNFlAVRNQWBoCeGJ4eFhGdpsBUWvU10HhlJSmpwkADPtdcXGxpr+/X5kXzHsRPhlFwo+qq6vLMkBen++kLxB4n8IOp+wOxxyZRNBhqYxeQrKhSDTSTQAJAEl6VySyw+5y7QVtS3hOwQsHg6HgHoVSkcTcImjZta1iW7tKrZpxu93LAoLfPsdZfkIxBsNvuFnKoA8ODiqgMhq96nIGwGqz/pQxHGL/ycxnNqHV68ecfr/HYDBM4Dx/RlUC+psU9I8A8EOKM/FfiRH8Rl8fs1ImzgYvryRDZXvIvMfjeSFDHyomYli+ZzjD7zivfiixqfje4gKtVnu+pqbGZzSZkoH8/H2U1+9/Bonm4dREBkRwCH3Lu5RK0yj/Cso+pdHpRqGWRZIUc5fQGXa5Pe7XAJbSs8wF9LpKq9VaI9jtRyGOVpjaS7o0wKuouro6D0D+4jju1QxIWbwse2dT0w4E3oMXWbQcA+63V1ZWHqitrb0fftET6khDjcfjPofb1QWxvFsUi70SCoWsZA1V7QVDf4OuwHJSh9M5gMZ2YXx8XELdocGwzBhrYE9CytKVD5RKo5qFuj4gvWeT+bOK7i56HNTONzY2hv/bBp4HbcmCcEHdZhDcfn9EppBdA81v37TY09NDm63WYXTja0VFRaTFZG0UAF4JodFOqtXq0zgrftUgaFuFL+NxWkYn4eb9GwFA/MMypWJaqVKdQVfXrxvc3t6uwwfndch3Ht/uE1DHU+DWulpsQ0ODwRvw7oQJv0H/S6E7fwwWbv2HoqWlJYTfnlPwyyyuJcHhmDLw/GHebOpijVyP0+U6L6WlpMVcZxjm14qKivLbOsTm5mYZ4Rk0PglhfAoqR+CRXywW03EDxx1B69+H9Rg8pFovz7+QG17HSFkXRwAAAABJRU5ErkJggg==",
                    show: "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABcAAAAWCAYAAAArdgcFAAAAAXNSR0IB2cksfwAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAACXBIWXMAAAsTAAALEwEAmpwYAAACW0lEQVRIx6WVz2sTQRTHpwipKBZBKKgHQfSknr0ZxINOViWJNRVvghe3iVntJqY9exAFxa0gVTx5SpPa1Nqku1sFf+AfoPg3eFJPHjzV73s7m8zGbJLGw4edfW/m82ZnlhkhzWpCmkunpFnLy5nlx2ABOCOwwOPJw75qQqCRlDP16wgKJGOod7EcD3vIt5Skl1keECtHPN8QsvBasRrE+svZK9TnxEhXROrmukgVN0TK8hQux7hgvyLwxspTxZYmdYkx9QxilEMfmkA/udNT3Ba1eQgWwc5oXBX5V+50yWvo2NRnS+wA98GW4lmvAjL/aoCc1jg663HwSBOHPAe7o8vU6v6TdHk92LzorOdDoSy6DrinFXjQ2QePv3iA/I0unwArLLbcJ+mSdzRb9g6hfVfJ34HJ/5E3MNsXads7nKv4H8HXTNk/LoOler8tuSysCeOWK84H7DUsNwnxidyc/+lyxd8iUOBLtuSdpBz67A/6esKw+srxC2LHp8quyFU2gU8cAZ+V+Af4pdrfED+m+ojpuU1xqbQhzpkxckpk7KbIoSMGEwnwVMl+gqvgIviuYjWwi/rSmOwgeXp2XZfvAWvgD7iiYoQBfoMPYHJU+T6wCK5p4pBp8BIcHF5+m+RvMZgLjIMDYIzep+54TJDjPIknwveM3eopbx9cvO6YPW8qZsNfASFtllEIDihq63lqZ+3WcKciFQiKNHnQheKqOHujc7RS2yg0OEfQH9Y1Y03eviyiHcIiMQPjc6a6rcy6PeQ1tw0619xpEVzQ1TMIWtpFO+oF7bCHfdXEXxOVLT1VmiQNAAAAAElFTkSuQmCC",
                    hide: "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABcAAAAWCAYAAAArdgcFAAAAAXNSR0IB2cksfwAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAACXBIWXMAAAsTAAALEwEAmpwYAAACbElEQVRIx6WVy2sTURSHbxFSUSyCUFAXguhKXbsziAu90yhJH6m4E9yY59gmse3ahVho6USQKq5c5VGTKmknM1HwgX+A4t/gSl25cBV/58wdO5NJpmm7+JiZ8/jOvLhXyFQlAq7JVE2X6Q0DlNVxrzh95GFfJSJkqnpVpuv3EBRIBriRqveND8yxh3zVKC7qBVzQMdCoZRsilmuK6/eDgykWy28KmXntH8Ln5KvNC/U4PimRmN8SU0VTTD+0+FxTEpJOZJscm0FuEjXxuVa/pyj75I60JaZLbZFc7DAzCzYfKUbDeKDKuzkiERzAcsMrpztJLr7jRjAGTjvnnR7sEXAKjJKc+nrkxgB5x5WT+BWYVdde7oJ1cGK/8nHwEfwBEx7xbfAXvAXHhpZPlUwxu0Tvkd6nfQTUIOiCH+AWuAN+UQy5ZyBC9dQXKqffKKZvi5tzNrBE7AH+lKJ1AYLvasBv8FOJv8QL1rkY6qie+mSonP7P/JaQugXaxElNb0cnS9bl5IL9VQ0g8edEwbqEfBQc53rqS+8i11CkoRhSYhx8gGA1UbIvYsA38Al3fFbm2y+Ra4Ixrt+n/D3oYsAjPMGZeNE6j/OnFAONg8hHwLISdXG3j4HhXoMlp25o+bZXThwFLzxCl1Uwugf5Bi9Emm565cRh8NwjfgIO7eSHlTPuALN3wDpY8Q82+Wn7LMlGYFX0/ZaZJhrNnbv7/x0sJ07STGPQel8OkbvUsK6/EVrO86FzLR5MuZDeMi/qanEPKVQbAIbI7Ga41NmJ1GaB7Shsm+s7JKzGv83RBl29gmAGybUDbtBr7GFfJfIPsVIsl2DrA+cAAAAASUVORK5CYII="
                };
                n.active_app = null, n.convert_name_to_description = function (t) {
                    return t === i || "string" != typeof t ? "" : s.map(t.split("_"), function (t) {
                        return t.substring(0, 1).toUpperCase() + t.substring(1)
                    }).join(" ")
                };
                var _ = new Array;
                _.push(o({
                    name: "share",
                    description: "Share This Page",
                    draw_button: function () {
                        return '<img src="' + b.share + '" alt="Share This Page" />' + '<div class="ts_share_text">Share</div>'
                    },
                    load_content: function (t) {
                        this.loaded = !0, this.display_div.html(function () {
                            var t = [];
                            return t.push(' <div class="ts_share_title"> Share via... </div> <div class="ts_share_links"> <a href="javascript:;" class="ts_share_link" data-url="//turnsocial.com/mail_share/new?mail_share[url]={url}&mail_share[title]={title}" data-name="email" > <img src="//turnsocial.com/assets/share/email-a4c177c54fd17a403ae2359ba43a836e.png" /> email </a> <a href="javascript:;" class="ts_share_link" data-url="https://www.facebook.com/sharer.php?u={url}&t={title}" data-name="facebook" > <img src="//turnsocial.com/assets/share/facebook-b071084cade307f6638811884cb9dfc6.png" /> facebook </a> <a href="javascript:;" class="ts_share_link" data-url="https://twitter.com/share?text={title}%20-%20{url}" data-name="twitter" > <img src="//turnsocial.com/assets/share/twitter-695b62185fc5e699e3f1bc6ff80e2924.png" /> twitter </a> <a href="javascript:;" class="ts_share_link" data-url="http://reddit.com/submit?url={url}&title={title}" data-name="reddit" data-width="840" > <img src="//turnsocial.com/assets/share/reddit-9076a65a2ee278bb954c12b4f2c74d91.png" /> reddit </a> <a href="javascript:;" class="ts_share_link" data-url="http://www.stumbleupon.com/submit?url={url}&title={title}" data-name="stumbleupon" data-width="800" > <img src="//turnsocial.com/assets/share/stumbleupon-14d16bd928c23b1ba50b4d132aab886a.png" /> stumbleupon </a> </div>'), t.join("")
                        }()), t()
                    },
                    onload: function () {
                        s(".ts_share_link").click(function () {
                            var t = s('meta[itemprop^="name"]').attr("content") || s('meta[property^="og:title"]').attr("content") || document.title,
                                e = location.href,
                                i = s(this);
                            p.track("share", {
                                name: i.data("name")
                            });
                            var o = i.data("url").replace("{url}", encodeURIComponent(e)).replace("{title}", encodeURIComponent(t)),
                                r = i.data("width") || 635;
                            return h.new_window(o, {
                                width: r,
                                height: 700
                            }, function () {
                                n.active_app.deactivate()
                            }), !1
                        })
                    }
                })), d += "#ts #ts_share_link{font-size:10px;font-family:Verdana, Arial, Helvetica, sans-serif;margin-right:8px;height:23px;border:1px solid #ddd;padding:0 2px;border-radius:4px;box-shadow:0, 1, 1, #aaaaaa;background-color:#dddddd;background-image:-webkit-linear-gradient(#eee, #ddd);background-image:linear-gradient(#eee, #ddd)}#ts #ts_share_link>*{margin:0 2px;display:inline-block;vertical-align:middle;line-height:18px}#ts #ts_share{-webkit-box-sizing:border-box;-moz-box-sizing:border-box;box-sizing:border-box;width:770px;height:260px;left:50%;margin-left:-385px;top:50%;margin-top:-130px;border-width:5px;opacity:0.95;text-align:center}#ts #ts_share .ts_share_title{font-size:24px;font-weight:bold;padding:20px 0}#ts #ts_share .ts_share_links{display:inline-block;text-align:center}#ts #ts_share .ts_share_links .ts_share_link{cursor:pointer;display:inline-block;text-align:center;font-size:18px;margin:20px}#ts #ts_share .ts_share_links .ts_share_link img{cursor:pointer;width:100px;height:100px;display:block;padding-bottom:10px}\n", _.push(r({
                    name: "facebook_fan",
                    description: "Facebook Fan Page",
                    icon: "facebook",
                    src: "//www.facebook.com/plugins/likebox.php?id=123954514355408&width=500&height=560&colorscheme=light&show_faces=true&border_color&stream=true&header=false&connections=22&force_wall=true&appId=101244151430"
                })), _.push(n({
                    name: "facebook_like",
                    description: "Like this page",
                    draw_button: function () {
                        var t = "https://www.facebook.com/plugins/like.php?href=" + encodeURIComponent(location.href) + "&layout=button_count&show_faces=true&width=100&action=like&colorscheme=light&height=21";
                        return '<iframe src="' + t + '"' + 'scrolling="no" frameborder="0" ' + 'id="ts_facebook_like" ' + 'allowTransparency="true"></iframe>'
                    }
                })), _.push(n({
                    name: "google_plusone",
                    description: "Google +1",
                    draw_button: function () {
                        var t = "https://plusone.google.com/u/0/_/+1/fastbutton?url=" + encodeURIComponent(location.href) + "&size=medium&count=true&db=1&hl=en-US";
                        return '<iframe allowtransparency="true" frameborder="0" hspace="0" marginheight="0" marginwidth="0" scrolling="no" src="' + t + '" ' + 'id="ts_google_plusone" ' + 'vspace="0" width="100%"></iframe>'
                    }
                })), u.bind("insert", function () {
                    x(g.visible !== !1), s("#ts .ts_bar").slideDown(), u.trigger("show"), p.track("social_bar")
                });
                var y, x = function (t) {
                        t ? (s("#ts_app_links").css({"display":"inline-block",'margin-right':'150px'}), s("#ts_hide_link img").attr("src", b.hide), y.description = "Hide the toolbar") : (s("#ts_app_links").css("display", "none"), s("#ts_hide_link img").attr("src", b.show), y.description = "Show the toolbar"), s("#ts_toolbar_arrow").animate({
                            opacity: t
                        })
                    };
                y = n({
                    name: "hide",
                    "protected": !0,
                    click: function () {
                        n.current_app && current_app.deactivate(), s(".ts_tooltip").stop(!0, !1).fadeOut(100);
                        var t = s("#ts_app_links").is(":visible");
                        s(".ts_bar").slideUp(function () {
                            x(!t), u.trigger(t ? "hide" : "show"), s(".ts_bar").slideDown()
                        }), g.visible = !t, g.save()
                    }
                }), _.push(y), _.push(n({
                    name: "turnsocial",
                    description: "TurnSocial Toolbar",
                    "protected": !0,
                    click: function () {
                        window.open("http://turnsocial.com")
                    }
                })), s.each(_, function () {
                    var t = this,
                        e = s("<div />", {
                            "class": "ts_tooltip"
                        });
                    c.append(e), t.link.mouseenter(function () {
                        e.text(t.description), e.stop(!0, !0).fadeTo(100, 1), e.position({
                            of: s(this),
                            my: "center bottom-10",
                            at: "center top",
                            collision: "fit fit"
                        })
                    }), t.link.mouseleave(function () {
                        e.stop(!0, !1).fadeOut(100)
                    })
                }), p.track("load", {
                    site: window.location.href,
                    agent: navigator.userAgent,
                    referrer: document.referrer
                }), s(t.wrap(function () {
                    if ("Microsoft Internet Explorer" == navigator.appName) {
                        var t = navigator.userAgent,
                            e = new RegExp("MSIE ([0-9]{1,}[.0-9]{0,})");
                        if (null != e.exec(t)) {
                            var i = parseFloat(RegExp.$1);
                            if (8 > i) return
                        }
                    }
                    var n = /(Android)|(webOS)|(iPad)|(iPhone)|(iPod)/i;
                    navigator.userAgent.match(n) || ("CSS1Compat" !== document.compatMode && console.log("Warning - page is in quirks mode. TurnSocial may render incorrectly."), s("#ts").length > 0 || (s("body").append(c), s("head").append("<style>" + d + "</style>"), u.trigger("insert")))
                }))
            }
        });
    ! function () {
        var t, i, n, o, r, a;
        return o = "1.10", a = function (t, e) {
            return 0 === t.indexOf(e)
        }, i = function (t) {
            return "string" == typeof t && a(t, o)
        }, window.jQuery && jQuery.fn && i(jQuery.fn.jquery) ? e(jQuery) : (r = document.createElement("script"), o += ".2", r.src = "//ajax.googleapis.com/ajax/libs/jquery/" + o + "/jquery.min.js", n = document.getElementsByTagName("head")[0], t = !1, r.onload = r.onreadystatechange = function () {
            var i;
            return i = !this.readyState || "loaded" === this.readyState || "complete" === this.readyState, !t && i ? (t = !0, e(jQuery.noConflict(!0)), r.onload = r.onreadystatechange = null, n.removeChild(r)) : void 0
        }, n.appendChild(r))
    }()
}();
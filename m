To: linuxppc-dev@lists.linuxppc.org
Subject: TiPBG4 sleep stops working with linux-2.4.6-pre8-benh
From: gtgj@pacbell.net (Gregorio Gervasio Jr.)
Date: 04 Jul 2001 02:02:31 -0700
Message-ID: <m3ith9m5i0.fsf@adsl-63-196-7-11.dsl.snfc21.pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


        ... The screen goes blank but the LED doesn't blink.  I need
to reboot with Ctrl-Cmd-Power.  This is using "snooze" or closing the
lid, with pmud-0.7-2.  This worked with at least linux-2.4.5-pre3-benh.

The last thing in the syslog is:

Jul  4 00:38:23 localhost pmud[744]: initiating user requested sleep
Jul  4 00:38:23 localhost pmud[744]: running /etc/power/pwrctl sleep ac
Jul  4 00:38:23 localhost pwrctl: no function for PMU 12

When linux-2.4.5-pre3 works, this would be followed by:

Jul  4 00:21:41 localhost pmud[753]: going to sleep

Note that this is while running X11.  In multi-user console,
2.4.5-pre3 also fails to sleep, although it again works fine in
single-user console.  The 2.4.6-pre8 kernel fails in all modes.

        Any ideas?

Gregorio Gervasio, Jr.
gtgj@pacbell.net

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

From: Benjamin Herrenschmidt <bh40@calva.net>
To: mberglund <matt@realestatesafari.com>, <linuxppc-dev@lists.linuxppc.org>,
        <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Kernel compile errors in latest snap
Date: Fri, 18 Aug 2000 11:41:45 +0200
Message-Id: <20000818094145.16616@mailhost.mipsys.com>
In-Reply-To: <Pine.LNX.4.21.0008180131200.1723-100000@europa.rcinfo.net>
References: <Pine.LNX.4.21.0008180131200.1723-100000@europa.rcinfo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>[root@ linuxppc_2_3]# grep -r input_keycode drivers
>drivers/macintosh/mac_keyb.c:static void input_keycode(int, int);
>drivers/macintosh/mac_keyb.c:   input_keycode(data[1], 0);
>drivers/macintosh/mac_keyb.c:           input_keycode(data[2], 0);
>drivers/macintosh/mac_keyb.c:input_keycode(int keycode, int repeat)
>drivers/macintosh/mac_keyb.c:   input_keycode(last_keycode, 1);
>drivers/input/adbhid.c:static void adbhid_input_keycode(int, int, int);
>drivers/input/adbhid.c: input_keycode(id, data[1], 0);
>drivers/input/adbhid.c:         input_keycode(id, data[2], 0);
>drivers/input/adbhid.c:adbhid_input_keycode(int id, int keycode, int
>repeat)

In drivers/input/adbhid.c, replace input_keycode by adbhid_input_keycode.
I though I pushed this fix before I left, but since I had some problems
with bk, it may still be pending in my local tree. I'll fix all that this
week-end (maybe tonight).

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

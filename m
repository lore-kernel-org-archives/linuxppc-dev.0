Date: Sun, 20 Apr 2003 14:01:36 +0200
From: Boris Bezlaj <boris@gajba.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: ADB HID compile error in 2.5.x
Message-ID: <20030420120136.GA4166@gajba.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello,
  is anyone working on ADB HID driver for 2.5.x ?

I get the following compile error:

drivers/macintosh/adbhid.c: In function `adbhid_keyboard_input':
drivers/macintosh/adbhid.c:137: too many arguments to function `adbhid_input_keycode'
drivers/macintosh/adbhid.c:139: too many arguments to function `adbhid_input_keycode'
drivers/macintosh/adbhid.c: At top level:
drivers/macintosh/adbhid.c:143: syntax error before "pt_regs"
drivers/macintosh/adbhid.c: In function `adbhid_input_keycode':
drivers/macintosh/adbhid.c:144: number of arguments doesn't match prototype
drivers/macintosh/adbhid.c:87: prototype declaration
drivers/macintosh/adbhid.c:147: `keycode' undeclared (first use in this function)
drivers/macintosh/adbhid.c:147: (Each undeclared identifier is reported only once
drivers/macintosh/adbhid.c:147: for each function it appears in.)
drivers/macintosh/adbhid.c:152: `id' undeclared (first use in this function)
drivers/macintosh/adbhid.c:152: `regs' undeclared (first use in this function)

--

  Boris

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

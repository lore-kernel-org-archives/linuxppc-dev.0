Date: Fri, 9 Jan 2004 14:10:27 +0100
From: Harald Welte <laforge@gnumonks.org>
To: linuxppc-dev@lists.linuxppc.org
Subject: Why does config MAC_EMUMOUSEBTN depend on INPUT_ADBHID ?
Message-ID: <20040109131027.GJ31820@sunbeam.de.gnumonks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi!

Can anybody please explain why this dependency exists?  On my desktop G4
machine, there is no need to compile ADB support, since it uses an usb
keyboard.  However, I'd still like to have the mouse button emulation.

I cannot select it without compiling the (for this machine) superfluous
ADB support.

Is this intentional?

--
- Harald Welte <laforge@gnumonks.org>               http://www.gnumonks.org/
============================================================================
Programming is like sex: One mistake and you have to support it your lifetime

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

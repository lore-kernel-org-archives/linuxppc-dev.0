Date: Mon, 29 Jan 2001 10:29:56 +0000
Subject: correct use of lock_kernel() - help!  please
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="utf-8"
Message-Id: <20010129102946.9388A2EFC9@apollo.valhalla.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

In the driver I am working on (dmasound) someone has placed lock/unlock
_kernel() pairs around whole functions.

This means that (e.g.) if we release the sound device with a lot of
un-played samples at a low-ish sample rate...

AFACIT we could hold the kernel locked for *several seconds*

What do I really need to protect with lock/unlock pairs?

or am I missing something (it wouldn't be the first time ..) ;-?

ciao,
Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

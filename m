Message-ID: <39072136.6A4B340A@relog.ch>
Date: Wed, 26 Apr 2000 19:02:46 +0200
From: Michel Dänzer <daenzer@relog.ch>
Reply-To: daenzerm@student.ethz.ch
MIME-Version: 1.0
To: Ryuichi Oikawa <roikawa@rr.iij4u.or.jp>
CC: gewrgiou@imbc.gr, linuxppc-dev@lists.linuxppc.org
Subject: Re: XFree 4.0 dual monitor on AGP G4
References: <Pine.LNX.4.21.0004261635150.27506-100000@idd-01.imbc.gr> <20000427015351E.roikawa@rr.iij4u.or.jp>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Ryuichi Oikawa wrote:

> BTW, why do people like fbdev very much?

- one can use the generic fbdev driver if the dedicated driver doesn't work
- if the dedicated driver supports fbdev, access to the hardware is
  coordinated between all virtual terminals
- ...


> It's easier to port XFree86 built-in drivers as Kostas mentioned before, and > has advantages that developers can port/update the server independent on the
> kernel, add support the latest hardware without waiting for the kernel
> driver, etc.

Use of the fbdev support is optional.


Michel


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

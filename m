To: daenzerm@student.ethz.ch
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: XFree 4.0 dual monitor on AGP G4
In-Reply-To: Your message of "Wed, 26 Apr 2000 19:02:46 +0200"
	<39072136.6A4B340A@relog.ch>
References: <39072136.6A4B340A@relog.ch>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Message-Id: <20000429013726U.roikawa@rr.iij4u.or.jp>
Date: Sat, 29 Apr 2000 01:37:26 +0900
From: Ryuichi Oikawa <roikawa@rr.iij4u.or.jp>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > BTW, why do people like fbdev very much?
>
> - one can use the generic fbdev driver if the dedicated driver doesn't work
> - if the dedicated driver supports fbdev, access to the hardware is
>   coordinated between all virtual terminals
But XFree has excellent drivers(and extensions) optimized for the X server
and they work with a slight modification(at least for mga and r128 cases,
AFAIK. I like easy way). And we do access drawing eigine directly...

> Use of the fbdev support is optional.
I misunderstood non-using fbdev support is optional in the ppc world
reading discussions on the list...

BTW, I don't hate fbdev at all. It is the only way to provide large
console on linux and also very important for X server to support 1st
generation PCI macs' on-board video, etc.


Thank you,

Ryuichi Oikawa
roikawa@rr.iij4u.or.jp

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Message-ID: <3A316DDD.E1B5B28F@student.ethz.ch>
Date: Sat, 09 Dec 2000 00:25:17 +0100
From: Michel Dänzer <daenzerm@student.ethz.ch>
MIME-Version: 1.0
To: Leonhard Jaschke <jaschke@inf.ethz.ch>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: XF4.01 + r128 + 3D hardware accel?
References: <3A2F811A.B54AC48D@inf.ethz.ch>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Leonhard Jaschke wrote:

> Just wondered: Is there a 3D hardare accelleration in XF4.01 for
> the Rage 128? If so, how can I make use of that feature?

No.

I have been working on PPC support in a branch of the DRI CVS repository, but
due to the lack of AGP or PCI GART support it's not really usable yet.

This is hopefully going to change soon, the author of the driver intends to
add PCI GART support. I'll post back here when it's ready.


Michel


--
Earthling Michel Dänzer (MrCooper)  \  CS student and free software enthusiast
Debian GNU/Linux (powerpc,i386) user \   member of XFree86 and The DRI Project

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

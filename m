Message-ID: <3804503F.74B93796@arcormail.de>
Date: Wed, 13 Oct 1999 10:26:27 +0100
From: Michael Fenske <michael.fenske@arcormail.de>
Reply-To: michael.fenske@arcormail.de
MIME-Version: 1.0
To: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
CC: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: Problem with glibc-2.1.3-0a.src.rpm ?
References: <3803A7BC.4175E431@arcormail.de>
		 <3803A7BC.4175E431@arcormail.de> <v03110700b4298a016f5d@[209.183.131.16]>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


"Kevin B. Hendricks" wrote:
> 
> 1. goto /usr/lib/gcc-lib and search downwards and remove all of the old
> egcs subdirectories hanging around (just leave the latest gcc ones from
> Franz's gcc-2.95.1

I removed them already.

> 
> 2. add a symbolic link
>    ln -s 2.95.1 gcc-2.95.1

I made this link and tried rebuilding glibc-2.1.3.0a again. But the
configure script continues to believe I have egcs installed.

Michael

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

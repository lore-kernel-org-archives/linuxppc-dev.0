Message-ID: <3BC2061B.F76C90D4@mvista.com>
Date: Mon, 08 Oct 2001 16:01:31 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
Cc: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: status of gdb with recent linuxppc devel kernel for 405GP
References: <3BC1ABB7.65546D76@esd-electronics.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Matthias Fuchs wrote:

> is it currently possible to use gdb with the recent devel version of the
> 405GP kernel ?
> It seems not, am I right ?

There were some issues with context switching the debug registers that
I didn't sort out when I pushed the recent changes.  I believe I just
received, or will soon receive, a patch from Armin that will correct this.

> Some weeks ago somebody send me a patch for the old 2.4.2 kernel to get
> gdb working. Is this checked in already ?

I don't believe that will work in the latest kernel.  All of the recent
updates I have made came from the HHL 2.0 release, which is based on
a 2.4.2 kernel. The gdb support is certainly working there, and if it would
have merged without changes, it would also be in the latest tree.

Thanks.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

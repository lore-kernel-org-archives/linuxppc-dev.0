Message-Id: <4.2.0.58.19991001160701.04839100@mail.lauterbach.com>
Date: Fri, 01 Oct 1999 16:08:44 +0200
To: Alvin Brattli <Alvin.Brattli@phys.uit.no>
From: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
Subject: Re: [Fwd: Bug: 2.2.12 still hangs PPC after some PPP activity]
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <Pine.OSF.3.96.991001153658.16772E-100000@mitra.phys.uit.no
 >
References: <4.2.0.58.19991001150704.03c6b230@mail.lauterbach.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 15:46 01.10.99 , Alvin Brattli wrote:

>On Fri, 1 Oct 1999, Franz Sirl wrote:
>
> >(I'm using vger nearly unmodified)
>
>This is one thing that has been escaping me for quite a while:  how do I
>get a specific version of the vger kernel, and how do I get a list of
>the versions I can checkout?  Following the instructions given on
><http://cvs.on.openprojects.net/> only gives me the current vger
>development kernel (2.3.X), and not for example the latest 2.2.X kernel
>(actually, the "kernel" module does seem to exist on cvs.on.openprojects.net;
>after trying different things, "linux" worked, and gave me a 2.3.X kernel).
>Reading the CVS man files haven't helped me much either.
>Can some kind soul enlighten me on this?

cvs update -dP -rlinux_2_2

Franz.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

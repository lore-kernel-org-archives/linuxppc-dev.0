Message-ID: <397F6686.20E2D953@wanadoo.fr>
Date: Thu, 27 Jul 2000 00:30:30 +0200
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: tom_gall@vnet.ibm.com
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: modprobe and exec format error
References: <397F60D4.E5A417E6@vnet.ibm.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


tom_gall@vnet.ibm.com wrote:
>
> Hi All,
>
>   Here's a strange one...
>
>   I'm bringing up a 2.4.0-testX kernel (Paul's latest PMac tree) and the kernel
> does come up quite a ways (tho how far is a bit hard to tell as things scroll by
> and scroll lock doesn't work)

If you compile MagicSysRq support in, you can stop scrolling by
"SysRq-0" (that is F13 + zero).

> I get the following repeated item on my screen ... so imagine this line times N
>
> /sbin/modprobe -s -k binfmt_4c46 errno=8
>
> Well errno 8 is Exec format error as I recall...    time to upgrade modutils?
>
> Anyone with any suggestions or have seen this one before?

Yeah, seen this before:
http://lists.linuxppc.org/listarcs/linuxppc-dev/200007/msg00327.html
and my solution:
http://lists.linuxppc.org/listarcs/linuxppc-dev/200007/msg00345.html

I'm curious what your reason was for getting this.

--
Martin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

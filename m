Message-ID: <3AAD05BA.96B7E87D@mvista.com>
Date: Mon, 12 Mar 2001 10:22:02 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
Reply-To: mgreer@mvista.com
MIME-Version: 1.0
To: xav <grave@ipno.in2p3.fr>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: How to find information for the Raven Chip ?
References: <3AAC909F.9DE40CC9@ipno.in2p3.fr>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


What I usually do is go to the Motorola website and download the
Programmer's Reference Guide for an MCG board that uses the Falcon/Raven
(e.g., MVME3600/4600).  Those usually have pretty good descriptions of
the Falcon/Raven.

Mark
--

xav wrote:

> Hi,
>
> After I have followed the Matt's advice, I was able
> to request irq for my tundra universe chip on my 2303
> board (with 2.4.2 kernel from bk tree). But when I enable vme
> irq 6 on it : it seems that this irq is always on (no problem with
> others vme irq). Where can I look for the
> information about level/edge in the Raven chip ?
>
> Thanks in advance, xavier
>
> --
> 33 (0) 1 69 15 79 59
> De chacun selon ses forces, a chacun selon ses besoins
>

--
Mark A. Greer (mgreer@mvista.com; 480-517-0287)
MontaVista Software, Inc.
2141 E. Broadway Road, Suite 108
Tempe, AZ  85282


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

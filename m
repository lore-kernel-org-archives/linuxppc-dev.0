Message-ID: <3E3567A3.5010600@esteem.com>
Date: Mon, 27 Jan 2003 09:08:51 -0800
From: Conn Clark <clark@esteem.com>
MIME-Version: 1.0
To: Steven Scholz <steven.scholz@imc-berlin.de>
Cc: May Ling List <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: gcc-3.2 and MPC8xx
References: <3E34F6A0.2040209@imc-berlin.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Steven Scholz wrote:
>
> Hi there,
>
> I read that MontaVista released a 3.0 with gcc 3.2.
>
> Does it make sense to switch from 2.95.3/4 to gcc 3.2 for MPC8xx PowerPC?
>
> Are there any big advantages when building u-boot, kernel, drivers,
> busybox and
> multithreaded applications?
>
> Thanks a million,
>
> Steven
>
>
>
>
>

I don't know about using gcc 3.2 on PPC but on X86 its wonderful. 3.2.X
(mabey even 3.1.x) has two features called profile-arcs and
branch-probabilities that can boost speed quite a bit. Read the gcc man
page on how to use these options.

Good Luck

	Conn
--

*****************************************************************
   If you live at home long enough, your parents will move out.
  (Warning they may try to sell their house out from under you.)
*****************************************************************

Conn Clark
Engineering Stooge				clark@esteem.com
Electronic Systems Technology Inc.		www.esteem.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

Message-ID: <3C1F4FD2.B855C7FD@cambridgebroadband.com>
Date: Tue, 18 Dec 2001 14:16:50 +0000
From: Alex Zeffertt <ajz@cambridgebroadband.com>
MIME-Version: 1.0
To: None Atall <linux_meis@yahoo.com>,
	linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: ATM driver for 8260 (linux 2.4.x) + more questions
References: <20011218135613.13181.qmail@web9706.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


None Atall wrote:
>
>  By the way, as I can see from mpc860sar code, the
> ATM device is connected on SCCx via utopia. Our board
> (MPC8260ADS and our custom one) have the ATM connected
> on FCC1. Will I need too many changes after the patch?
> Can anyone evaluate the changes that i will need?
> We are running out of time, so I wonder...
>
>                                   Thanks a lot!
>                                       D.Meidanis
>


As I understand it there is no FCC1 on the 860.  This is something you get with the 8260 only.  With
the 860 you need to use the utopia interface.

I wrote the code for the 860 so there is no support for FCC ATM.  You'll have to read the 8260 UM to
work out how much there is to do.

Alex

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

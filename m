Message-ID: <3C164C50.C20778D6@mvista.com>
Date: Tue, 11 Dec 2001 10:11:28 -0800
From: Armin Kuster <Darth_vapor@mvista.com>
MIME-Version: 1.0
To: Felix Radensky <felix@allot.com>
Cc: David =?iso-8859-1?Q?M=FCller?= (ELSOFT AG) <d.mueller@elsoft.ch>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: ppc405_enet problems
References: <3C14B86D.726DBDE6@allot.com> <3C15BB05.7070702@elsoft.ch> <3C160B04.93085D47@allot.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Felix Radensky wrote:
>
> Hi,
>
> Thanks, David and Armin for your help. I've tried the methods you suggested
> but none of them worked. The real problem in my case was the MAX_NUM_PHYS
> constant. I've noticed that after the first for loop in find_phy routine, the
> value of
> i is MAX_NUM_PHYS. So I've tried to increase the value of this constant, and
> my
> phy was (almost) discovered properly after the 5th iteration. I say almost,
> because
> I also had to change the value of phy id from 0x20005c23 to 0x20005c20 (the
> value
> reported by find_phy. Armin, can you please explain how this number was
> determined.

Felix,

I took the easy route, its just phyid1 & phyid2.  The "A" version was
submitted by some one else and it might be possible to combine them into
one DP83843 stuct by using a shift factor of 8 ( 2nd eliment in the
phy_info struct" the diff between 0x20005c23 &  0x20005c20 is the model
revision number.

Maybe MAX_NUM_PHYS needs to be renamed to MAX_PHY_ADDR to be more clear.


-- armin

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

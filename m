Message-ID: <20040122034730.55118.qmail@web21409.mail.yahoo.com>
Date: Wed, 21 Jan 2004 19:47:30 -0800 (PST)
From: Huailin Chen <chen_huailin@yahoo.com>
Subject: Re: any one use 750fx/MV64360
To: Xiaoshan Zuo <xzuo@vinesystech.com>,
	linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <400F1270.7000107@vinesystech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


My 2 cents:

I happened to use all your options these years:--(.

750fx + 64260
it should be good enough if you don't have
MP(Multi-CPU) demand for running smp-os on top of it.
The reason is obivous: 750fx is G3. The MEI protocol
may not be prefered if your system happens to be a
high-end applicances.

750fx + 64360

if you do want to stay 750 and need SMP, you may have
to use 64360. Check out Marvell FAE people to
understand their Arbiter part, which have some fixes
for SMP support. If you have legacy issue, note that
some tiny porting work needed for 64360 part.

7447 + 64260
No one would go for this option

7447 + 64360

Well, G4+ MES(R)I is born to support SMP system. So,
if you concern this part, do go for it. One thing you
need talk to your hardware board group is: Powerp
Consumption. If you guys are able to live with it, go
for it:-).

Also, if you have legacy codes under IBM 750-based
system, please pay high alert on driver part. For
example, Out of Order issue when under Non-Cachable
and Guard......One missing will make your driver all
srew up. For more detail, you are welcome to talk to
me.

Good luck,
Huailin Chen
www.xtrj.org




--- Xiaoshan Zuo <xzuo@vinesystech.com> wrote:
>
> Hello,
>
> We are planning design a custom board. The preferred
> cpu is IBM 750FX,
> the bridge is going to be Marvell 64360. Depending
> on the software
> support, we may alter our plan to use either
> 750FX/64260 or Motorola
> 7447/64360/64260. It seems that 64360 is not
> supported in stock kernel,
> there is galieo tree for that, but I am not sure the
> code is really
> stable. Anyone has experience using 750fx/64360?
> Which version of
> gcc/kernel/u-boot should I use? If that is not a
> good option, then how
> about 750FX/64260 or Motorola 7447/64360/64260? Any
> suggestions/comments
> will be appreciated.
>
> Thanks,
>
> Xiaoshan
>
>


Yahoo! SiteBuilder - Free web site building tool. Try it!
http://webhosting.yahoo.com/ps/sb/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

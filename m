Message-Id: <5.1.0.14.0.20020530091533.0233eda0@pop.gmx.de>
Date: Thu, 30 May 2002 09:17:29 +0200
To: "zhongqx" <zhongqx@guoguang.com.cn>,
	<linuxppc-embedded@lists.linuxppc.org>
From: Michael Habermann <MHabermann@gmx.de>
Subject: Re: Dram is not good on FADS860T board!
Cc: "MirekP" <ntr_stukacz@poczta.onet.pl>
In-Reply-To: <001d01c20795$86b62240$7301a8c0@zhongqx>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


At 12:50 PM 5/30/2002 +0800, zhongqx wrote:
>     Recently I want to run linux on FADS860T board,but i find thd DRAM of
> board can not work normally.

How much DRAM do you have? 16 MB DRAM collides with the SDRAM, so it works
only if SDRAM is disabled. 8 MB works on my system. 32MB, I've never
tested, but it should also work.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

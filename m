Message-Id: <5.1.0.14.2.20030925134712.03b0ef78@mail.ebshome.net>
Date: Thu, 25 Sep 2003 13:54:23 -0700
To: Roland Dreier <roland@topspin.com>
From: Eugene Surovegin <ebs@ebshome.net>
Subject: Re: Any restrictions on DMA address boundry?
Cc: Bret Indrelee <Bret.Indrelee@qlogic.com>,
	Matt Porter <mporter@kernel.crashing.org>,
	Linux PPC Embedded mailing list <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <52k77wk9mj.fsf@topspin.com>
References: <Pine.LNX.4.44.0309251306450.12966-100000@spider.ancor.com>
 <Pine.LNX.4.44.0309251306450.12966-100000@spider.ancor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


At 11:26 AM 9/25/2003, Roland Dreier wrote:
>People often come up with complicated schemes like flushing and
>invalidating the cache before and after the DMA transfer, but there's
>always a scenario where the DMA buffer and/or the unrelated data get
>corrupted.  The only solution is to make sure that you don't put
>unrelated data in the same cache line as a DMA buffer.

Well, I'm one of those strange people.
Actually, those schemes are quite trivial and they help in _real_ life.

I fully understand that they are not 100% foolproof, but I think they are
_better_ than doing _nothing_.
I already _wasted_ a lot of my time debugging cache coherency problems.

I cannot audit _all_ drivers/subsystems I use nor I can force their authors
do this.

Eugene.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

Message-ID: <3981BB7A.23043170@lightning.ch>
Date: Fri, 28 Jul 2000 18:57:30 +0200
From: Daniel Marmier <daniel.marmier@lightning.ch>
Reply-To: daniel.marmier@lightning.ch
MIME-Version: 1.0
To: Dan Malek <dan@netx4.com>
CC: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Altivec on 2.4.xx?
References: <3980DEAF.ACFB0C43@embeddededge.com> <39813520.673CF3E0@lightning.ch> <39819D52.DAC049B4@embeddededge.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Dan Malek wrote:
> This is a PowerPC architecture definition. It isn't unique to the MPC8xx,
> as I am obviously using a 7400 with Altivec here.

The exception I was talking about is _implementation specific_, which makes
it MPC8xx unique. I do not use Altivec, but I am afraid there could be
problems even without it. I could not find out whether the Data TLB Miss
exception sets the DSISR, but DataStoreTLBMiss can branch to DataAccess,
wich passes the DSISR to do_page_fault. Phew, hope I was clearer :-)
Anyway, I will look at this exception with care before telling more.

> Having the common page fault handler is a good thing, we just have
> to make sure we extract the information properly from the appropriate
> register.

Of course it is a good thing. I was just suggesting a way of retrieving
this information properly from do_page_fault.

> I thought there was more (than none :-) development happening with
> Altivec on PowerPC Linux.  Maybe tiny test applications will work,
> but my MPEG-2 decoder won't.

Sorry, only 8xx here :-(


				Daniel Marmier

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Subject: Re: [PATCH] PPC601 MQ handling
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stef Simoens <stef.simoens@pi.be>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>,
	Paul Mackerras <paulus@samba.org>
In-Reply-To: <HZG4L6$A14A0723F533A1C86A3AF192DB6EF298@scarlet.be>
References: <HZG4L6$A14A0723F533A1C86A3AF192DB6EF298@scarlet.be>
Content-Type: text/plain
Message-Id: <1087489624.8556.248.camel@gaston>
Mime-Version: 1.0
Date: Thu, 17 Jun 2004 11:27:06 -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 2004-06-17 at 04:19, Stef Simoens wrote:
> > Did you check it was actually saved/restored by the signal code ?
> >
> > Ben.
>
> I looked up when XER gets saved/restored to save/restore MQ.
>
> I tested my patch with
> mqtest &
> (start other programs which are 'MQ-enabled')
> fg
> ^Z
> ...
> and mqtest gave me the correct output.

I was concerned about arch/ppc/kernel/signal.c but it seems that it's ok,
it will save & restore it properly.

Paul, do we want this patch in ?

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Date: Wed, 21 Aug 2002 17:19:11 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Restructuring of ibm_ocp_enet driver
Message-ID: <20020821071911.GL18818@zax>
References: <20020821043627.GF18818@zax> <5.1.0.14.2.20020820231900.03a9e008@pop.prodigy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5.1.0.14.2.20020820231900.03a9e008@pop.prodigy.net>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Aug 20, 2002 at 11:26:03PM -0700, Eugene Surovegin wrote:
>
> David,
>
> At 09:36 PM 8/20/2002, you wrote:
> >The patch below make some first steps to restructuring the
> >ibm_ocp_enet driver .
>
> Wouldn't it be nice BEFORE another ibm_ocp_enet restructuring to fix bugs
> introduced in the previous one?

Well, I'm thinking about this in 2.5.  There's no way the current OCP
setup stuff will go in.

> Current version has broken rx ring buffer management and the typo in
> requesting IRQ for RXDE event.

I noticed the RXDE problem while doing this work.  What's the problem
with Rx buffer management?

> I send bug report and a fix (maybe not the most elegant one) to Armin two
> weeks ago. Nothing happened :(

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

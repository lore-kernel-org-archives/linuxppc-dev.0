Message-ID: <3F140F1E.1050303@stinkfoot.org>
Date: Tue, 15 Jul 2003 10:26:38 -0400
From: Ethan Weinstein <e-d0uble@stinkfoot.org>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: aic7xxx panics (long)
References: <3EFFD86B.7060007@stinkfoot.org>	 <1056957083.32576.112.camel@gaston>  <3F00E86B.1000309@stinkfoot.org>	 <1057053589.32576.310.camel@gaston>  <3F02537C.1090801@stinkfoot.org>	 <1057148769.32104.422.camel@gaston>  <3F04D1EA.6060906@stinkfoot.org>	 <1057590248.11707.62.camel@gaston>  <3F140C6E.2080609@stinkfoot.org> <1058278673.515.2.camel@gaston>
In-Reply-To: <1058278673.515.2.camel@gaston>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt wrote:

> I've been turning that problem in my mind for some time now, I suspect
> some breakage at the PCI level....
>
> Do you have an IDE disk you can boot from ? That would help... That way,
> you can send me the lspci -vvv output of a working vs. a non-working
> kernel...
>
> Ben.

I'm sure I do somewhere.  When I get home this evening I'll throw
together a simple system the boots from the IDE controller, and have at
it.  Would you like to see anything besides `lspci -vvv` for both kernels?

Ethan


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

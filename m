Subject: Re: aic7xxx panics (long)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ethan Weinstein <e-d0uble@stinkfoot.org>
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <3F140C6E.2080609@stinkfoot.org>
References: <3EFFD86B.7060007@stinkfoot.org>
	 <1056957083.32576.112.camel@gaston>  <3F00E86B.1000309@stinkfoot.org>
	 <1057053589.32576.310.camel@gaston>  <3F02537C.1090801@stinkfoot.org>
	 <1057148769.32104.422.camel@gaston>  <3F04D1EA.6060906@stinkfoot.org>
	 <1057590248.11707.62.camel@gaston>  <3F140C6E.2080609@stinkfoot.org>
Content-Type: text/plain
Message-Id: <1058278673.515.2.camel@gaston>
Mime-Version: 1.0
Date: 15 Jul 2003 16:17:54 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 2003-07-15 at 16:15, Ethan Weinstein wrote:

>
> Looks as if Gibbs is uninterested in helping here, he hasn't replied to
> several problem reports regarding this issue and I'm not going to push
> it.  For the hell of it, I tried out CONFIG_SCSI_AIC7XXX_OLD and it
> prodces the _exact_ same oops.. Different driver, same crash.. thoughts?

I've been turning that problem in my mind for some time now, I suspect
some breakage at the PCI level....

Do you have an IDE disk you can boot from ? That would help... That way,
you can send me the lspci -vvv output of a working vs. a non-working
kernel...

Ben.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

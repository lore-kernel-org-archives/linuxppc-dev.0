Message-ID: <3F04D1EA.6060906@stinkfoot.org>
Date: Thu, 03 Jul 2003 21:01:30 -0400
From: Ethan Weinstein <e-d0uble@stinkfoot.org>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: aic7xxx panics (long)
References: <3EFFD86B.7060007@stinkfoot.org>	 <1056957083.32576.112.camel@gaston>  <3F00E86B.1000309@stinkfoot.org>	 <1057053589.32576.310.camel@gaston>  <3F02537C.1090801@stinkfoot.org> <1057148769.32104.422.camel@gaston>
In-Reply-To: <1057148769.32104.422.camel@gaston>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Ben,

Same oops with your dev tree (2.4.22-pre2-ben0). I'll post it as I did
the last one if you'd like, but it looks nearly identical.  What to try
next?

Ethan


Benjamin Herrenschmidt wrote:
>
> Ok, it's real strange now. It seems you get that machine check on
> the first access to the second controller while the first works fine,
> though both appear to be configured properly on the PCI bus. It
> looks like the second controller isn't responding on the MMIO
> addresses... Can you try my devel tree with the updated driver ?
> (just in case it changes anything....) I see no reason for this
> problem right now though...
>
> Ben.
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

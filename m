Subject: Re: aic7xxx panics (long)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ethan Weinstein <e-d0uble@stinkfoot.org>
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <3F04D1EA.6060906@stinkfoot.org>
References: <3EFFD86B.7060007@stinkfoot.org>
	 <1056957083.32576.112.camel@gaston>  <3F00E86B.1000309@stinkfoot.org>
	 <1057053589.32576.310.camel@gaston>  <3F02537C.1090801@stinkfoot.org>
	 <1057148769.32104.422.camel@gaston>  <3F04D1EA.6060906@stinkfoot.org>
Content-Type: text/plain
Message-Id: <1057590248.11707.62.camel@gaston>
Mime-Version: 1.0
Date: 07 Jul 2003 17:04:09 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 2003-07-04 at 03:01, Ethan Weinstein wrote:
> Ben,
>
> Same oops with your dev tree (2.4.22-pre2-ben0). I'll post it as I did
> the last one if you'd like, but it looks nearly identical.  What to try
> next?

Right now, I'm a bit clueless...

You can try asking the driver maintainer ?

Tell him that from what I see, the card seems to be properly mapped
on the PCI bus, function 0 works, but access to a function 1 register
is causing a Target Abort error on the PCI...

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

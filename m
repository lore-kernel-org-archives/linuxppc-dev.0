Message-ID: <3F140C6E.2080609@stinkfoot.org>
Date: Tue, 15 Jul 2003 10:15:10 -0400
From: Ethan Weinstein <e-d0uble@stinkfoot.org>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: aic7xxx panics (long)
References: <3EFFD86B.7060007@stinkfoot.org>	 <1056957083.32576.112.camel@gaston>  <3F00E86B.1000309@stinkfoot.org>	 <1057053589.32576.310.camel@gaston>  <3F02537C.1090801@stinkfoot.org>	 <1057148769.32104.422.camel@gaston>  <3F04D1EA.6060906@stinkfoot.org> <1057590248.11707.62.camel@gaston>
In-Reply-To: <1057590248.11707.62.camel@gaston>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt wrote:

  > Right now, I'm a bit clueless...
>
> You can try asking the driver maintainer ?
>
> Tell him that from what I see, the card seems to be properly mapped
> on the PCI bus, function 0 works, but access to a function 1 register
> is causing a Target Abort error on the PCI...
>
> Ben.
>

Ben,

Looks as if Gibbs is uninterested in helping here, he hasn't replied to
several problem reports regarding this issue and I'm not going to push
it.  For the hell of it, I tried out CONFIG_SCSI_AIC7XXX_OLD and it
prodces the _exact_ same oops.. Different driver, same crash.. thoughts?

Ethan


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

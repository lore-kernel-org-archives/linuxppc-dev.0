Message-ID: <3C77EA8C.20505@embeddededge.com>
Date: Sat, 23 Feb 2002 14:16:28 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Jerry Van Baren <vanbaren_gerald@si.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: custom mpc8240 student project (long)
References: <C08678384BE7D311B4D70004ACA371050B7632E4@amer22.avnet.com> <5.1.0.14.2.20020222070057.01f28df8@falcon.si.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Jerry Van Baren wrote:


> I suspect that it's about sanity preservation, not control.

This is exactly the reason and all semiconductor companies do this.
They use the NDA as a mechanism to track who may be calling for support,
not to necessarily protect any information.  This is done for several
categories of features, not only the COP (in the case of Motorola).

> By the way, the 3rd party tool costs are NOT astronomical.  Entry level is
> $50 for a BDM4GDB, $150 for a Macraiger Wiggler.

For BDM devices, yes.  The COP tools are usually more expensive, except in
the case of more flexible tools like those from Abatron where the hardware
cost can be amortized across a wide range of devices.  Due to the complexity
of COP, I think everyone uses some kind of hardware acceleration just to
make it usable.  You have to be moving bits at megabit speeds to make
reasonable progress with COP, especially when you are debugging operating
systems with MMUs and caches enabled on the processor.

Of course, for those of us that work for a living, these tools can pay for
themselves in a matter of hours :-).


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

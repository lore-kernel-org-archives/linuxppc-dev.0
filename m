Message-ID: <3ECE9678.2040506@embeddededge.com>
Date: Fri, 23 May 2003 17:45:28 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Jim Rowe <rowejames@acmsystems.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: MPC8250 + PCMCIA + airo_cs card + IO Port mapping proble
References: <5.1.0.14.2.20030522143346.04b7e260@falcon.si.com>	 <1053662461.16860.17.camel@kneedragger> <1053728074.29793.30.camel@kneedragger>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Jim Rowe wrote:

> ....It would be even better if you are
> using an MPC82xx chip with an integrated PCI controller.

Take a look at the 8245 with the integrated MPC10x PCI bridge.
Basically, the Sandpoint port.  The 8250 is a more simple
implementation than this.  The 405GP/Walnut would also be
a good example, just don't get mired in the details that it
doesn't have BATs :-)


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

Message-ID: <40058CCD.7040208@embeddededge.com>
Date: Wed, 14 Jan 2004 13:39:09 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Milliorn Gary-rxcr80 <Gary.Milliorn@motorola.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: TLB and CSSBAR problems with MPC8540 and BDI2000
References: <5725AF6EE9FAD51195DC009027E377020B6562DD@az33exm35.corp.mot.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Milliorn Gary-rxcr80 wrote:

>   The TLB1 issue is due to the MPC85x0 errata "CPU4"; there's a s/w
> workaround.  It's nice if BDI fixes it for you, but seems like it would
> not be necessary.

The BDI doesn't fix anything.  I was just expecting the 'invalidate
protect' to actually do that. :-)  I set up several TLB1 entries during
the BDI initialization prior to debugging the boot rom.  The boot rom
then does a flash invalidate and loads up a "new" set of TLB1 entries.
I was expecting the values I set with the BDI to co-exist with the
new ones, but that doesn't seem to be the case.

Thanks.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

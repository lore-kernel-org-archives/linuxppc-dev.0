Date: Mon, 31 Mar 2003 11:43:15 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: John F Davis <johndavi@us.ibm.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: pcmcia microdrive support on 2.4.21-rev5 for arctic2
Message-ID: <20030331014315.GA4043@zax>
References: <OFDE2F5CD3.5BAB6AAA-ON87256CF7.0051250D-85256CF7.0051C351@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <OFDE2F5CD3.5BAB6AAA-ON87256CF7.0051250D-85256CF7.0051C351@us.ibm.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Mar 28, 2003 at 09:52:46AM -0500, John F Davis wrote:
>
> Hello David,
>
> You indeed are correct again.  I made the change to the pcmcia config file
> and it now associates the ide-cs.o with the microdrive.  However, I still
> have problems.  It outputs the following message:
> ide-cs: Get NextTuple: No more items
> ide-cs: Get NextTuple: No more items
>
> Also:
> "fdisk /dev/hda"  Says "unable to open /dev/hda"
>
> I also don't see ide in the /proc/devices file.  This sounds like a
> problem.

Yes, the module has failed to initialize - I think this message
usually means that it's failed to find a configuration in the CIS that
it deems suitable.  Why that's happened, I'm not so sure,
unfortunately.

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

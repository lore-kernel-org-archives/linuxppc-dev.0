Date: Mon, 22 Dec 2003 15:27:28 +0100 (CET)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: "David D. Kilzer" <ddkilzer@kilzer.net>
Cc: Jeff Garzik <jgarzik@pobox.com>,
	<tulip-devel@lists.sourceforge.net>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: [PATCH] Fix byte-swapped ethernet addr for Asante Fast 10/100
 PCI Adapter
In-Reply-To: <20031207062153.GB6302@permusion.kilzer.net>
Message-ID: <Pine.LNX.4.44.0312221520490.10152-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>   Original:  00:00:B5:94:71:86  [INCORRECT]
>    Patched:  00:00:94:B5:86:71  [CORRECT]
>
> Is it sufficient to simply check the first two bytes of the mac address
> to determine this?  (This is what the attached patch does.  I added a
> check for the first byte being 0x00 for the Asante card.)
>
> Should the first three bytes of the mac address be used intead?  (Note
> that I can only identify 00:A0:CC as one of the Lite-On mac addresses
> that would be matched by the code segment above.  I don't see a 00:C0:**
> entry for Lite-On in the IEEE database.)

I'd check the first three bytes (after byte swapping :-) - there's plenty
of other OUIs with the leading two bytes zero.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Return-Path: <markc@mail.com>
Received: from relay02.roc.ny.frontiernet.net (relay02.roc.ny.frontiernet.net
	[66.133.131.35]) by ozlabs.org (Postfix) with ESMTP id 637DF2BD6A
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  4 Oct 2004 22:07:44 +1000 (EST)
Received: from filter02.roc.ny.frontiernet.net
	(filter02.roc.ny.frontiernet.net [66.133.131.177])
	by relay02.roc.ny.frontiernet.net (Postfix) with ESMTP id 393721014D
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  4 Oct 2004 12:07:35 +0000 (UTC)
Received: from relay02.roc.ny.frontiernet.net ([66.133.131.35])
	by filter02.roc.ny.frontiernet.net (filter02.roc.ny.frontiernet.net
	[66.133.131.177]) (amavisd-new, port 10024)
	with LMTP id 31011-76-36 for <linuxppc-embedded@ozlabs.org>;
	Mon, 4 Oct 2004 12:07:35 +0000 (UTC)
Received: from chuck2 (170-215-150-221.br1.rmn.wv.frontiernet.net
	[170.215.150.221])
	by relay02.roc.ny.frontiernet.net (Postfix) with ESMTP id F096D101DD
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  4 Oct 2004 12:07:31 +0000 (UTC)
Message-ID: <000b01c4aa0b$018aeae0$0301a8c0@chuck2>
From: "Mark Chambers" <markc@mail.com>
To: <linuxppc-embedded@ozlabs.org>
References: <35fb2e59040930165327f2dd59@mail.gmail.com>	<87127382-1357-11D9-8EFC-000393DBC2E8@freescale.com><20041001220648.GJ21896@smtp.west.cox.net>
	<4160E898.9080905@intracom.gr>
Date: Mon, 4 Oct 2004 08:09:27 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Re: bi_recs
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


> 
> I just create an argv of all the environment variables of the firmware
> and I pass the psysical address of that NULL terminated argv array
> to the kernel command line like so... "u-boot-env=0x0f000f00".
> 

This would be a variation of the "human readable ASCII format"
technique, right?  I had once ventured to offer my opinion that this
would be a technique that could work for all architectures, which is
a big plus, IMO.   My mistake was suggesting XML, which I think
was [mis]understood by some as requiring a lot more than a few
extra "</" type characters.  I'm offering my opinion not as an expert
but as someone who not too long ago tried to puzzle through the
bootloader/kernel interface and found it unnecessarily obscure.  I
think an ASCIIZ string array of some sort would be immediately
obvious and thus highly maintainable by all.

Mark Chambers

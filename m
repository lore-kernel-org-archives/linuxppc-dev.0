Return-Path: <mgalassi@c-cor.com>
Received: from penguin.ncube.com (penguin.ncube.com [134.242.67.78])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2BD9467C24
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  5 Dec 2006 04:08:30 +1100 (EST)
Message-Id: <200612041708.kB4H8OQo059150@penguin.ncube.com>
To: "t.denzinger" <t.denzinger@lesametric.de>
Subject: Re: Updating plb_temac to version 3.00.a on XILINX ml403 board 
In-reply-to: <45744834.8090804@lesametric.de> 
References: <45744834.8090804@lesametric.de>
Date: Mon, 04 Dec 2006 09:08:24 -0800
From: Michael Galassi <mgalassi@c-cor.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

>I have a plb_temac-design based on XAPP902 demodesign running. It's 
>based on plb_temac version 2.00.a and hard_temac version 1.00.a.
>I tried to update to version 3.00 manually, because of incompatibility 
>for automatic update.
>Up to now without success.
>Can somebody help me with a  copy of .mhs and .ucf files, where the 
>interface to the PHY and the PPC is correct?

They're largish so I put copies of the ones I used with the ml403 on my
web server, look for:

http://www.xyz.com/system.ucf
http://www.xyz.com/system.mhs

I didn't clean out other unrelated changes.

-michael

Return-Path: <eemingliu@hotmail.com>
Received: from bay0-omc3-s17.bay0.hotmail.com (bay0-omc3-s17.bay0.hotmail.com
	[65.54.246.217]) by ozlabs.org (Postfix) with ESMTP id 3D92967A3A
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  5 Dec 2006 07:51:06 +1100 (EST)
Message-ID: <BAY110-F3705CEAB1430F552659908B2DF0@phx.gbl>
In-Reply-To: <45744834.8090804@lesametric.de>
From: "Ming Liu" <eemingliu@hotmail.com>
To: t.denzinger@lesametric.de
Subject: RE: Updating plb_temac to version 3.00.a on XILINX ml403 board
Date: Mon, 04 Dec 2006 20:51:01 +0000
Mime-Version: 1.0
Content-Type: text/plain; charset=gb2312; format=flowed
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

Hi,
To update the TEMAC, you can simply delete the old cores and add the new 
ones from the core list, without editing the .mhs manually. Also, if you 
have EDK 8.2, when you build a new design, the TEMAC whose version is 3.00 
could be added automatically. 

Now I am also doing the similar work as yours. However, if you want to use 
the TEMAC 3.00 driver for linux 2.6 provided by EDK in Linux, maybe it will 
be not so easy. I am trying to do that, but I keep failing for a long time. 
So I am still using the old cores and the patched driver from the website. 
:(

If any progress, pls let's tell each other.

BR
Ming


>From: "t.denzinger" <t.denzinger@lesametric.de>
>To: linuxppc-embedded@ozlabs.org
>Subject: Updating plb_temac to version 3.00.a on XILINX ml403 board
>Date: Mon, 04 Dec 2006 17:09:24 +0100
>
>Hi all,
>
>I have a plb_temac-design based on XAPP902 demodesign running. It's
>based on plb_temac version 2.00.a and hard_temac version 1.00.a.
>I tried to update to version 3.00 manually, because of incompatibility
>for automatic update.
>Up to now without success.
>Can somebody help me with a  copy of .mhs and .ucf files, where the
>interface to the PHY and the PPC is correct?
>
>best regards
>
>Thomas
>
>--
>___________________________________________________
>Thomas Denzinger
>LesaMetric GmbH
>Hauptstrasse 46
>D-35649 Bischoffen
>
>Phone:	+49(0)6444/9319-28
>Fax:    +49(0)6444/9319-12
>eMail:	T.Denzinger@LesaMetric.de
>
>_______________________________________________
>Linuxppc-embedded mailing list
>Linuxppc-embedded@ozlabs.org
>https://ozlabs.org/mailman/listinfo/linuxppc-embedded

_________________________________________________________________
√‚∑—œ¬‘ÿ MSN Explorer:   http://explorer.msn.com/lccn/  

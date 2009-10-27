Return-Path: <suvidh.kankariya@ntigo.com>
Received: from nti1.com (nti1.com [65.243.248.10])
	by ozlabs.org (Postfix) with ESMTP id A8B2AB7BD8
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 28 Oct 2009 02:56:52 +1100 (EST)
Received: from PC140.ntigo.com (host82.networktechinc.com [65.243.248.82] (may
	be forged)) by nti1.com (8.14.1/8.14.3) with ESMTP id n9RFn3ep028623
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 27 Oct 2009 10:49:08 -0500 (EST)
Message-Id: <200910271549.n9RFn3ep028623@nti1.com>
Date: Tue, 27 Oct 2009 11:47:51 -0500
To: linuxppc-dev@lists.ozlabs.org
From: suvidh kankariya <suvidh.kankariya@ntigo.com>
Subject: Re:Micrel PHY KSZ8001 on MPC5200B FEC
In-Reply-To: <mailman.1186.1256651657.12812.linuxppc-dev@lists.ozlabs.or
 g>
References: <mailman.1186.1256651657.12812.linuxppc-dev@lists.ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Romen,
A driver for micrel phy exists in /drivers/net/phy/micrel.c. in 2.6.30.
You just need to add the structure with your phy information .

If you are using older kernel you may want to copy it.



Regards

Suvidh







>------------------------------
>
>Message: 6
>Date: Tue, 27 Oct 2009 13:17:27 +0100
>From: Roman Fietze <roman.fietze@telemotive.de>
>To: linuxppc-dev@lists.ozlabs.org
>Subject: Micrel PHY KSZ8001 on MPC5200B FEC
>Message-ID: <200910271317.28007.roman.fietze@telemotive.de>
>Content-Type: text/plain;  charset="iso-8859-1"
>
>Hello,
>
>We would need some help on how to make a Micrel KSZ8001 work on the
>MPC5200B FEC using the kernel DENX-v2.6.3[01].
>
>We can already boot the kernel and device tree using TFTP and this PHY
>using a recent U-Boot version, so we would need some pointers how to
>acomplish that.
>
>Add a proper PHY driver in the Theirdirectory?
>
>Modify the DTS? If yes, how? A link to some documentation that's not
>already in the kernel sources would already help.
>
>Is it correct, when looking at the sources, that the MPC's FEC driver
>switched to the generic PHY driver interface?
>
>
>Roman
>
>--
>Roman Fietze                Telemotive AG B?ro M?hlhausen
>Breitwiesen                              73347 M?hlhausen
>Tel.: +49(0)7335/18493-45        http://www.telemotive.de
>
>
>------------------------------

Return-Path: <tnt@246tNt.com>
Received: from outmx002.isp.belgacom.be (outmx002.isp.belgacom.be
	[195.238.3.52]) by ozlabs.org (Postfix) with ESMTP id 14F2967A3E
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 19 May 2005 04:30:43 +1000 (EST)
Received: from outmx002.isp.belgacom.be (localhost [127.0.0.1])
	by outmx002.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with
	ESMTP id j4IIUWs1023915
	for <linuxppc-embedded@ozlabs.org>; Wed, 18 May 2005 20:30:33 +0200
	(envelope-from <tnt@246tNt.com>)
Message-ID: <428B8A0A.4040204@246tNt.com>
Date: Wed, 18 May 2005 20:31:38 +0200
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: Steven Blakeslee <BlakesleeS@embeddedplanet.com>
References: <1628E43D99629C46988BE46087A3FBB9247587@ep-01.EmbeddedPlanet.local>
In-Reply-To: <1628E43D99629C46988BE46087A3FBB9247587@ep-01.EmbeddedPlanet.local>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: USB-host driver for 440ep (bamboo)?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


> U-boot 1.1.3 has a usb_ohci.c driver for the MPC5200.  That driver with just a few changes worked like a champ on the 440EP.

If it's just a big endian OHCI, ohci-ppc.c that's currently in the 
mainstream tree should work, just add the proper definition in the 
platform devices.


Sylvain

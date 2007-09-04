Return-Path: <clemens.koller@anagramm.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id CCE0CDDD0B
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  4 Sep 2007 22:28:06 +1000 (EST)
Message-ID: <46DD4F69.8060804@anagramm.de>
Date: Tue, 04 Sep 2007 14:28:25 +0200
From: Clemens Koller <clemens.koller@anagramm.de>
MIME-Version: 1.0
To: schardt <g.schardt@fz-juelich.de>
Subject: Re: Thanks and new problems
References: <46DD4B6A.3020401@fz-juelich.de>
In-Reply-To: <46DD4B6A.3020401@fz-juelich.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Linux PPC Linux PPC <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

schardt schrieb:
> First, many many thanks to Grant. My VirtexII Demo Board ist running a
> 2.6. Linux :))
> 
> But now, i switched to a Virtex4-Board with Ethernet (Mini Module from
> Avnet)
> This will i used in my application, if i can handle it. :)
> 
> Linux is up and running, the ethernet is detected as eth0, link led is on
> but, and thats the problem, speed negotiating das not work.

Check the PHY configuration (i.e. the bootstrap pins on the PHY).

And - if appropriate - read out the PHY configuration (MDIO) and see
if it's correct.

Regards,
-- 
Clemens Koller
__________________________________
R&D Imaging Devices
Anagramm GmbH
Rupert-Mayer-Straße 45/1
Linhof Werksgelände
D-81379 München
Tel.089-741518-50
Fax 089-741518-19
http://www.anagramm-technology.com

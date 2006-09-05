Return-Path: <clemens.koller@anagramm.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id A4CA267BC1
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  6 Sep 2006 04:11:54 +1000 (EST)
Message-ID: <44FDBCAA.6040009@anagramm.de>
Date: Tue, 05 Sep 2006 20:06:34 +0200
From: Clemens Koller <clemens.koller@anagramm.de>
MIME-Version: 1.0
Subject: Re: [U-Boot-Users] OT: Re: Status of OF in TQM8540 and linux-2.6.17.11
References: <20060905153925.F1384353A15@atlas.denx.de>
In-Reply-To: <20060905153925.F1384353A15@atlas.denx.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Hi, Wolfgang!

Success!

>> The upper defines need to reside in the board-specific code for tqm as well as for other boards
>> utilizing such scheme (see platforms/85xx/mpc85xx_ads_common.h for instance).
>
>
> Thanks for pointing out.
>
> Clemens, plese try again (commit id cd4ebbc9b95434977e5f182b9a22d7d1de0748ce)


Jup, that works!
Just for the records: As of Sept 05 2006,
U-Boot 1.1.4-gf60ba0d3 and linux-2.6-denx-cd4ebbc9b (aka: 2.6.18-rc5-git)
is known to boot on the TQM8540 + STK85XX in the default configurations.

Thank you!

Clemens Koller
_______________________________
R&D Imaging Devices
Anagramm GmbH
Rupert-Mayer-Str. 45/1
81379 Muenchen
Germany

http://www.anagramm.de
Phone: +49-89-741518-50
Fax: +49-89-741518-19 

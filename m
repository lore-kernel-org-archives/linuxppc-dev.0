Return-Path: <clemens.koller@anagramm.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.179]) by ozlabs.org (Postfix) with ESMTP id 4812EDDDFD
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 20 Nov 2007 03:26:51 +1100 (EST)
Message-ID: <4741B934.90400@anagramm.de>
Date: Mon, 19 Nov 2007 17:26:28 +0100
From: Clemens Koller <clemens.koller@anagramm.de>
MIME-Version: 1.0
To: Timur Tabi <timur@freescale.com>
Subject: Re: Oops: of_platform_serial_probe
References: <474193B8.9060007@anagramm.de> <4741A617.1060207@freescale.com>
In-Reply-To: <4741A617.1060207@freescale.com>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
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

Timur Tabi schrieb:
 > Clemens Koller wrote:
 >
 >> I guess I didn't configure the OF serial right in the .dts but it still
 >> shouldn't crash. My .config is attached.
 >
 > Try disabling CONFIG_SERIAL_OF_PLATFORM.  I don't think it means what
 > you think it means.

Thanks, disabling CONFIG_SERIAL_OF_PLATFORM helps. but it still shouldn't crash...

Regards,

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

Return-Path: <clemens.koller@anagramm.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id E207CDDE06
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 14 Nov 2007 07:33:23 +1100 (EST)
Message-ID: <473A0A1B.3020302@anagramm.de>
Date: Tue, 13 Nov 2007 21:33:31 +0100
From: Clemens Koller <clemens.koller@anagramm.de>
MIME-Version: 1.0
To: robert lazarski <robertlazarski@gmail.com>
Subject: Re: 85xx Device tree problems: e0024520:02 not found
References: <f87675ee0711131217q6bb54e06q74f7d16e79b94f19@mail.gmail.com>
In-Reply-To: <f87675ee0711131217q6bb54e06q74f7d16e79b94f19@mail.gmail.com>
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

robert lazarski schrieb:
 > Hi all,
 >
 > I'm trying to bring up a new 8548 board on 2.6.23.1 . When booting,
 > Some times I can get as far mounting over nfs. However, it gets stuck
 > here:
 >
 > NET: Registered protocol family 1
 > NET: Registered protocol family 17
 > e0024520:02 not found
 > eth2: Could not attach to PHY
 > IP-Config: Failed to open eth2
 > IP-Config: Device `eth2' not found.

As already written in the u-boot-users list,
you could give the pauilis.git tree a try.

There have been recently (last month) several
PHY related changes. 2.6.23.1 seems to be too
"old".

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

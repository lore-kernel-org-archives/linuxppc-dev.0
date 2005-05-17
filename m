Return-Path: <clemens.koller@anagramm.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id 9525A679E2
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 17 May 2005 21:56:14 +1000 (EST)
Message-ID: <4289DBE9.9080002@anagramm.de>
Date: Tue, 17 May 2005 13:56:25 +0200
From: Clemens Koller <clemens.koller@anagramm.de>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: What ethernet driver to use in 2.6.8.1 instead of gianfar in
	2.6.11.x?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello, again,

for some tests and glibc-builds I want to work with a 2.6.8.1 kernel
temporarily on a freescale mpc8540.

In 2.6.8.1 there was no gianfar ethernet driver. Is it okay to use the
fec drivers instead of the gianfar or is it better to put the gianfar
drivers back into 2.6.8.1? (100Mbps are okay for that testing)

Maybe somebody can get me a working .config for 2.6.8.1 and mpc8540ads?

Thanks in advance,

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

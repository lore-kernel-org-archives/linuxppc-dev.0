Return-Path: <clemens.koller@anagramm.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id BD5C7DDE19
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 22 Nov 2007 22:17:03 +1100 (EST)
Message-ID: <47456510.3000808@anagramm.de>
Date: Thu, 22 Nov 2007 12:16:32 +0100
From: Clemens Koller <clemens.koller@anagramm.de>
MIME-Version: 1.0
To: Misbah khan <misbah_khan@engineer.com>
Subject: Re: Firmware Support for USB Hub
References: <13877282.post@talk.nabble.com>
	<474468C5.8080402@freescale.com>	<200711211830.02997.laurentp@cse-semaphore.com>
	<13894278.post@talk.nabble.com>
In-Reply-To: <13894278.post@talk.nabble.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Misbah khan schrieb:
 > Laurent Pinchart-4 wrote:
 >> On Wednesday 21 November 2007 18:20, Scott Wood wrote:
 >>
 >> If I remember correctly, CPM2 USB host support requires the host to create
 >> SOF
 >> packets in software. High system loads will probably mess the bus up. A
 >> colleague of mines was told by Freescale to use an external USB controller
 >> instead of the MPC8248 bundled one.
 >>
 >> I have posted this quarry to freescale. Anyway if you get more information
 >> could you please share with me ??

Well... can you post the source of this information. I would expect having
effects like this documented in the user manual or if it's really erratic
behaviour (and not a mess in an unmaintained piece of software) in an errata
sheet.

Please update.

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

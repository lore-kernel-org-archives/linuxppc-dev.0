Return-Path: <matt@genesi-usa.com>
Received: from mail.genesi-usa.com (mithrandir.softwarenexus.net
	[66.98.186.96])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 92CBEDDF19
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Apr 2007 03:39:27 +1000 (EST)
Message-ID: <461A7A65.2060505@genesi-usa.com>
Date: Mon, 09 Apr 2007 18:39:49 +0100
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: adding Pegasus IDE quirk for pata_via
References: <20070404111635.GA1855@aepfle.de>	<461A3C10.3050104@genesi-usa.com>
	<20070409154026.4d8a0774@the-village.bc.nu>
In-Reply-To: <20070409154026.4d8a0774@the-village.bc.nu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, Olaf Hering <olaf@aepfle.de>,
	linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Okay. I'll clean this up and submit a real patch to the Linux IDE mailing list (no point for
PowerPC guys to get any more of these since it is very generic Via IDE stuff now)

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations

Alan Cox wrote:
>> Again some comments would be appreciated from anyone who has a better idea on how this controller
>> works. This simple code addition came out of 2 or 3 days of discussion with the Pegasos designer
>> based on his experiences with the chip and is so simple there cannot be much wrong with it
>> apart from coding style and a distinct lack of testing.
> 
> Seems sane to me - as you said the x86 world relies on the BIOS for this
> and in fact pretty much never uses native mode anyway.
> 
> Patch looks fine except pci_find_device is obsolete, please use
> pci_get_device and refcount safe APIs.

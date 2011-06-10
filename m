Return-Path: <zajec5@gmail.com>
Received: from mail-qy0-f172.google.com (mail-qy0-f172.google.com
	[209.85.216.172]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 77D03B700E
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 11 Jun 2011 08:59:15 +1000 (EST)
Received: by qyk29 with SMTP id 29so116308qyk.17
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 10 Jun 2011 15:59:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.01.1106101552460.9183@trent.utfs.org>
References: <alpine.DEB.2.01.1105311644010.21697@trent.utfs.org>
	<alpine.DEB.2.01.1106011712270.21697@trent.utfs.org>
	<1306983467.29297.51.camel@pasglop>
	<alpine.DEB.2.01.1106101552460.9183@trent.utfs.org>
Date: Sat, 11 Jun 2011 00:59:10 +0200
Message-ID: <BANLkTimbt6wz_Wye8atkDbkGqh+KOfm9cg@mail.gmail.com>
Subject: Re: 3.0-rc1: powerpc hangs at Kernel virtual memory layout
From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To: Christian Kujau <lists@nerdbynature.de>
Content-Type: text/plain; charset=UTF-8
Cc: linux ppc dev <linuxppc-dev@lists.ozlabs.org>,
	LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

2011/6/11 Christian Kujau <lists@nerdbynature.de>:
> On Thu, 2 Jun 2011 at 12:57, Benjamin Herrenschmidt wrote:
>> John, care to send the patch below to Linus ASAP ? I could reproduce and
>> verify it fixes it. Thanks !
>>
>> ssb: pci: Don't call PCIe specific workarounds on PCI cores
>>
>> Otherwise it can/will crash....
>
> The patch did not make it into -rc2, it's not in today's git tree either,
> AFAICS. Can anyone push this, please?

Yeah, I noticed it wasn't in the pull for rc2. I pinged John, he told
me to just wait.

Patch was taken with the recent pull, it should go into rc3.

--=20
Rafa=C5=82

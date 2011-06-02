Return-Path: <zajec5@gmail.com>
Received: from mail-qy0-f179.google.com (mail-qy0-f179.google.com
	[209.85.216.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3F8A4B6F70
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  2 Jun 2011 16:00:23 +1000 (EST)
Received: by qyk7 with SMTP id 7so304250qyk.17
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 01 Jun 2011 23:00:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.01.1106011712270.21697@trent.utfs.org>
References: <alpine.DEB.2.01.1105311644010.21697@trent.utfs.org>
	<alpine.DEB.2.01.1106011712270.21697@trent.utfs.org>
Date: Thu, 2 Jun 2011 08:00:19 +0200
Message-ID: <BANLkTi=ceV9Xs0hpaAufE_+W1RPHyMCBow@mail.gmail.com>
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

2011/6/2 Christian Kujau <lists@nerdbynature.de>:
> On Tue, 31 May 2011 at 16:50, Christian Kujau wrote:
>> trying to boot 3.0-rc1 on powerpc32 only progresses until:
>>
>> =C2=A0 > Kernel virtual memory layout:
>> =C2=A0 > =C2=A0 * 0xfffcf000..0xfffff000 =C2=A0: fixmap
>
> After hours (and hours!) of git-bisecting, it said:
>
> -----------------------
> ccc7c28af205888798b51b6cbc0b557ac1170a49 is the first bad commit
> commit ccc7c28af205888798b51b6cbc0b557ac1170a49
> Author: Rafa=C5=82 Mi=C5=82ecki <zajec5@gmail.com>
> Date: =C2=A0 Fri Apr 1 13:26:52 2011 +0200
>
> =C2=A0 =C2=A0ssb: pci: implement serdes workaround
>
> =C2=A0 =C2=A0Signed-off-by: Rafa=C5=82 Mi=C5=82ecki <zajec5@gmail.com>
> =C2=A0 =C2=A0Signed-off-by: John W. Linville <linville@tuxdriver.com>
> -----------------------

I'm for the problem :(

Patch was already send yesterday, I've even CCed linuxppc-dev:
[RFT][PATCH 3.0] ssb: fix PCI(e) driver regression causing oops on PCI card=
s

--=20
Rafa=C5=82

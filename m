Return-Path: <jgpobox@gmail.com>
Received: from mail-qw0-f42.google.com (mail-qw0-f42.google.com
	[209.85.216.42]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0B662B6EEB
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Apr 2011 04:12:54 +1000 (EST)
Received: by qwi4 with SMTP id 4so1462213qwi.15
	for <linuxppc-dev@ozlabs.org>; Wed, 06 Apr 2011 11:12:51 -0700 (PDT)
Sender: Jeff Garzik <jgpobox@gmail.com>
Message-ID: <4D9CAD1F.6060500@garzik.org>
Date: Wed, 06 Apr 2011 14:12:47 -0400
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
To: "Moffett, Kyle D" <Kyle.D.Moffett@boeing.com>
Subject: Re: known working sata_sil24.c setup on powerpc platforms?
References: <BANLkTimXgi26RHHxyBLoN8YqaDy_PL-hGQ@mail.gmail.com>
	<C3A1EF35-6CB6-4674-8B0B-44CD1657FE87@boeing.com>
In-Reply-To: <C3A1EF35-6CB6-4674-8B0B-44CD1657FE87@boeing.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Leon Woestenberg <leon.woestenberg@gmail.com>,
	Linux PPC <linuxppc-dev@ozlabs.org>, Tejun Heo <htejun@gmail.com>,
	"linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/06/2011 01:48 PM, Moffett, Kyle D wrote:
> On Apr 06, 2011, at 13:00, Leon Woestenberg wrote:
>> after investigating problems with sata_sil24.c on a freescale p2020
>> soc, I wonder if this driver works on powerpc at all?
>>
>> Does anyone know of a working setup of sata_sil24 on a big endian
>> powerpc system?
>
> Our P2020 boards work fine with legacy PCI interrupts (I think it's a sil3124 over PCI-E); the only deficiency is that MSI does not seem to work.
>
> I know our MSI *does* work in general because we have an Intel 82571EB chipset also attached via PCI-E with working MSI.

We've definitely had issues with sata_sil24 + MSI, also...

sata_sil24 does work on big endian in general.

	Jeff

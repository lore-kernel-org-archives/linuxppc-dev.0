Return-Path: <micha@neli.hopto.org>
Received: from edu-smtp-02.edutel.nl (edu-smtp-02.edutel.nl [88.159.1.176])
	by ozlabs.org (Postfix) with ESMTP id 5C0D9B7D1A
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 16 Jun 2010 21:36:33 +1000 (EST)
Message-ID: <4C18B6AD.3030200@neli.hopto.org>
Date: Wed, 16 Jun 2010 13:34:05 +0200
From: Micha Nelissen <micha@neli.hopto.org>
MIME-Version: 1.0
To: Aggrwal Poonam-B10812 <B10812@freescale.com>
Subject: Re: [PATCH] e500v2 36 bit large physical HID0[EN_MAS7_UPDATE]
References: <4C187616.4000303@neli.hopto.org>
	<8660DA277DC57B4BAAC78225F03146B6AB1B5C@zin33exm24.fsl.freescale.net>
	<4C189860.3040702@neli.hopto.org>
	<8660DA277DC57B4BAAC78225F03146B6AB1BB3@zin33exm24.fsl.freescale.net>
In-Reply-To: <8660DA277DC57B4BAAC78225F03146B6AB1BB3@zin33exm24.fsl.freescale.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Aggrwal Poonam-B10812 wrote:
> Not sure of other platforms but on 85xx platforms on which I am
> currently working u-boot does LAW and eLBC programming for 36bit
> physical address. Hence 
> possibly u-boot has to made aware of large physical address space.
> Please correct me if I am wrong.

Yes, I can understand this for SDRAM and local flash interface. For 
RapidIO we have (local) patches to pass the law address range in the 
dtb. Perhaps also for PCI-express this might be done; U-boot has nothing 
to with these high speed interfaces (in our case at least).

Micha

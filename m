Return-Path: <micha@neli.hopto.org>
Received: from edu-smtp-02.edutel.nl (edu-smtp-02.edutel.nl [88.159.1.176])
	by ozlabs.org (Postfix) with ESMTP id D3C571007D3
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 16 Jun 2010 19:27:14 +1000 (EST)
Message-ID: <4C189860.3040702@neli.hopto.org>
Date: Wed, 16 Jun 2010 11:24:48 +0200
From: Micha Nelissen <micha@neli.hopto.org>
MIME-Version: 1.0
To: Aggrwal Poonam-B10812 <B10812@freescale.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] e500v2 36 bit large physical HID0[EN_MAS7_UPDATE]
References: <4C187616.4000303@neli.hopto.org>
	<8660DA277DC57B4BAAC78225F03146B6AB1B5C@zin33exm24.fsl.freescale.net>
In-Reply-To: <8660DA277DC57B4BAAC78225F03146B6AB1B5C@zin33exm24.fsl.freescale.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Aggrwal Poonam-B10812 wrote:
>> Attached is a patch to fix large physical address support for the
>
> This is already being done by u-boot, should linux set it again?

Yikes! Took me 5 min to reformat your email.

Our version of U-boot does not but it's not latest greatest.

IMHO:
1) Linux should not be dependent on U-boot or any other bootloader, or 
at least as possible
2) U-boot cannot (and does not want to) know whether Linux is going to 
use large physical addresses.

Regards,

Micha

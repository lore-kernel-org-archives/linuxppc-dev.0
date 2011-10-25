Return-Path: <B07421@freescale.com>
Received: from DB3EHSOBE001.bigfish.com (db3ehsobe001.messaging.microsoft.com
 [213.199.154.139])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id F28921007D9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Oct 2011 03:15:01 +1100 (EST)
Message-ID: <4EA6E07A.50102@freescale.com>
Date: Tue, 25 Oct 2011 11:14:50 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Bhushan Bharat-R65777 <R65777@freescale.com>
Subject: Re: IRQ2 and IRQ 3
References: <B8D6CA50DACE9E4AAADE9A4D56FBAAE623BEB3@039-SN1MPN1-005.039d.mgd.msft.net>
 <40631E9A2581F14BA60888C87A76A1FE016391@HYD-MKD-MBX4.wipro.com>
 <B8D6CA50DACE9E4AAADE9A4D56FBAAE623CED7@039-SN1MPN1-005.039d.mgd.msft.net>
In-Reply-To: <B8D6CA50DACE9E4AAADE9A4D56FBAAE623CED7@039-SN1MPN1-005.039d.mgd.msft.net>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "smitha.vanga@wipro.com" <smitha.vanga@wipro.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/18/2011 10:03 AM, Bhushan Bharat-R65777 wrote:
> Hi, 
> 
> For detail please look at ePAPR specification.
> 
> Say i2c interrupt number is 21 then you can try
> "interrupts = <21 8>;" in device tree.

Please read the FSL MPIC binding.  For internal interrupts, you need to
add 16 to the number in the manual.

-Scott

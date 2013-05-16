Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 4F6E02C00B1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 May 2013 16:34:29 +1000 (EST)
Message-ID: <1368686058.9603.46.camel@pasglop>
Subject: Re: SATA FSL and upstreaming
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bhushan Bharat-R65777 <R65777@freescale.com>
Date: Thu, 16 May 2013 16:34:18 +1000
In-Reply-To: <6A3DF150A5B70D4F9B66A25E3F7C888D0701C409@039-SN2MPN1-012.039d.mgd.msft.net>
References: <1368679657.9603.32.camel@pasglop>
 <1368683156.9603.34.camel@pasglop>
 <6A3DF150A5B70D4F9B66A25E3F7C888D0701C307@039-SN2MPN1-012.039d.mgd.msft.net>
 <3E027F8168735B46AC006B1D0C7BB0020B1E040F@039-SN2MPN1-011.039d.mgd.msft.net>
 <1368684547.9603.38.camel@pasglop>
 <3E027F8168735B46AC006B1D0C7BB0020B1E0442@039-SN2MPN1-011.039d.mgd.msft.net>
 <1368685428.9603.41.camel@pasglop>
 <6A3DF150A5B70D4F9B66A25E3F7C888D0701C409@039-SN2MPN1-012.039d.mgd.msft.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Liu Qiang-B32616 <B32616@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Fleming Andy-AFLEMING <afleming@freescale.com>,
 Zang Roy-R61911 <r61911@freescale.com>,
 Xie Shaohui-B21989 <B21989@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-05-16 at 06:33 +0000, Bhushan Bharat-R65777 wrote:
> From bank 0
> ------------
> 
> tftp 0x1000000  rcw_2sgmii_1500mhz.bin
> protect off 0xec000000 +$filesize; erase 0xec000000 +$filesize; cp.b
> 0x1000000 0xec000000 $filesize

Before I do something irreparable, what do you specifically mean by
"from bank 0" ? :-)

Cheers,
Ben.

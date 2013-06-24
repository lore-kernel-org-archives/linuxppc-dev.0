Return-Path: <pladow@gmail.com>
Received: from mail-ie0-x22f.google.com (mail-ie0-x22f.google.com
 [IPv6:2607:f8b0:4001:c03::22f])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B126B2C03DF
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Jun 2013 13:47:12 +1000 (EST)
Received: by mail-ie0-f175.google.com with SMTP id a13so23920724iee.34
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Jun 2013 20:47:09 -0700 (PDT)
References: <CAN8Q1EdnN9+kKGy+voF3=EyPfbHv04Emfz=uA6XKMJEAkvLpAA@mail.gmail.com>
 <CAN8Q1Ed9Lpg1Sog5tQODe+jqCRXBBH3d_UeR5usdc23CD7vwjg@mail.gmail.com>
 <1371945647.3944.106.camel@pasglop>
 <F3E9F49F-9C68-4BCB-B2A0-507AB1B2F10F@gmail.com>
 <1372036573.3944.115.camel@pasglop>
Mime-Version: 1.0 (1.0)
In-Reply-To: <1372036573.3944.115.camel@pasglop>
Content-Type: text/plain;
	charset=us-ascii
Message-Id: <C21F0308-2B77-42E6-9FC4-BF5428949A10@gmail.com>
From: Peter LaDow <pladow@gmail.com>
Subject: Re: Inbound PCI and Memory Corruption
Date: Sun, 23 Jun 2013 20:47:04 -0700
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Peter LaDow <petela@gocougs.wsu.edu>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>=20
>=20
> On Jun 23, 2013, at 6:16 PM, Benjamin Herrenschmidt <benh@kernel.crashing.=
org> wrote:
>> Also dbl check that the MMU is indeed mapping all these pages with the
>> "M" bit.
>=20
> Just to be clear, do you mean the e1000 registers in PCI space? Or the RAM=
 pages?
>=20
> Thanks,
> Pete

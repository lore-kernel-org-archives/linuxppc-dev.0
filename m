Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 721312C007C
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Jun 2013 13:50:07 +1000 (EST)
Message-ID: <1372045785.3944.130.camel@pasglop>
Subject: Re: Inbound PCI and Memory Corruption
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Peter LaDow <pladow@gmail.com>
Date: Mon, 24 Jun 2013 13:49:45 +1000
In-Reply-To: <C21F0308-2B77-42E6-9FC4-BF5428949A10@gmail.com>
References: <CAN8Q1EdnN9+kKGy+voF3=EyPfbHv04Emfz=uA6XKMJEAkvLpAA@mail.gmail.com>
 <CAN8Q1Ed9Lpg1Sog5tQODe+jqCRXBBH3d_UeR5usdc23CD7vwjg@mail.gmail.com>
 <1371945647.3944.106.camel@pasglop>
 <F3E9F49F-9C68-4BCB-B2A0-507AB1B2F10F@gmail.com>
 <1372036573.3944.115.camel@pasglop>
 <C21F0308-2B77-42E6-9FC4-BF5428949A10@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
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

On Sun, 2013-06-23 at 20:47 -0700, Peter LaDow wrote:
> > 
> > 
> > On Jun 23, 2013, at 6:16 PM, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> >> Also dbl check that the MMU is indeed mapping all these pages with the
> >> "M" bit.
> > 
> > Just to be clear, do you mean the e1000 registers in PCI space? Or the RAM pages?

The RAM pages.

Cheers,
Ben.

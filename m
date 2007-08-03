Return-Path: <tie-fei.zang@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9D5EEDDDF5
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Aug 2007 16:33:07 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l736X1YH014831
	for <linuxppc-dev@ozlabs.org>; Thu, 2 Aug 2007 23:33:01 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l736X0QC026520
	for <linuxppc-dev@ozlabs.org>; Fri, 3 Aug 2007 01:33:00 -0500 (CDT)
Subject: Re: [PATCH 1/2] Add sysdev/pci_quirks.c file into
	PowerPCarchitecture with ULI chip quirk functions.
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <05E0FF5A-03DB-441E-81E8-54BD4A215D32@kernel.crashing.org>
References: <11859560681182-git-send-email-wei.zhang@freescale.com>
	<11859560694083-git-send-email-wei.zhang@freescale.com>
	<1186005360.5495.529.camel@localhost.localdomain>
	<46B96294322F7D458F9648B60E15112C74D58E@zch01exm26.fsl.freescale.net>
	<1186017799.5495.546.camel@localhost.localdomain>
	<05E0FF5A-03DB-441E-81E8-54BD4A215D32@kernel.crashing.org>
Content-Type: text/plain
Message-Id: <1186122779.10419.0.camel@localhost.localdomain>
Mime-Version: 1.0
Date: 03 Aug 2007 14:32:59 +0800
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>,
	Zhang Wei-r63237 <Wei.Zhang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-08-02 at 12:29, Kumar Gala wrote:
> On Aug 1, 2007, at 8:23 PM, Benjamin Herrenschmidt wrote:
> 
> > On Thu, 2007-08-02 at 09:17 +0800, Zhang Wei-r63237 wrote:
> >> Hi, Ben,
> >>
> >>>
> >>> Are we sure that any powerpc machine that uses that ULI chip will 
> >>> need
> >>> the same quirk setting ?
> >>>
> >>
> >> We can ensure current platforms (as far as we know, MPC8544DS and
> >> MPC8641HPCN) using ULI chips in powerpc of kernel need the same
> quirk
> >> setting.
> >> And we hope to make them more generic. And if there are some  
> >> different
> >> setting in the future, we can add special codes.
> >
> > All right.
> 
> My feeling is this code is pretty specific to how the ULI M1575 is  
> used on those boards and should only be built for those boards.
Until now, it is right.
Roy

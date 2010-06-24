Return-Path: <B04825@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id CBD80B6F29
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jun 2010 07:21:00 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o5OLKvZs015719
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jun 2010 14:20:57 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id o5OLV4AN021502
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jun 2010 16:31:04 -0500 (CDT)
Message-ID: <4C23CC38.9040108@freescale.com>
Date: Thu, 24 Jun 2010 16:20:56 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Gary Thomas <gary@mlbassoc.com>
Subject: Re: UCC UART
References: <4C20CECB.9050609@mlbassoc.com> <4C20D162.2020302@freescale.com>
In-Reply-To: <4C20D162.2020302@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linux PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Timur Tabi wrote:
> I'd say that there are plenty of unknown issues with this driver/hardware. 
> For some reason, QE UART is just unreliable.  I've had several people try to 
> use the QE for UART, and almost everyone has problems with it.

I finally got in touch with one of the other development teams, and they
said that they got QE UART working with the 8569 and the P1021.  The
reference board we make with the 8568 does not have QE pinned to the UART,
so they didn't try to support that.

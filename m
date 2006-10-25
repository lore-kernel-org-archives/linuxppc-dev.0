Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17727.54702.140594.776697@cargo.ozlabs.ibm.com>
Date: Thu, 26 Oct 2006 07:22:54 +1000
From: Paul Mackerras <paulus@samba.org>
To: Matt Sealey <matt@genesi-usa.com>
Subject: Re: [PATCH] General CHRP/MPC5K2 Platform and drivers support - to
	comment
In-Reply-To: <453F7832.2020305@genesi-usa.com>
References: <453771E5.4090808@bplan-gmbh.de>
	<77AD49CA-69CB-4ADA-B8F3-3BC3A066BCF9@kernel.crashing.org>
	<453884F5.4000804@bplan-gmbh.de>
	<122A4E06-B8A6-4256-B96E-3811EA93EA25@kernel.crashing.org>
	<453B6A84.3050209@bplan-gmbh.de>
	<1161585371.10524.444.camel@localhost.localdomain>
	<453CD615.4050401@genesi-usa.com>
	<17725.18623.768768.438157@cargo.ozlabs.ibm.com>
	<453E34FB.3030209@genesi-usa.com>
	<17726.39780.732843.150044@cargo.ozlabs.ibm.com>
	<453F7832.2020305@genesi-usa.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Matt Sealey writes:

> It supports the original processors, G3, G4 etc. as well. Maybe not
> the 601? I'm not sure. All the PowerPC ISA Books are in there and
> information only seems to have been ADDED (or moved to another
> book or been given a new book).

The only 32-bit processors it supports are Book E processors.  IBM
removed all the material relating to 32-bit implementations from the
earlier V2.0x architectures, because IBM was no longer interested in
32-bit server processors.

Paul.

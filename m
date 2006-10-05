Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [208.106.21.240])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 1F41A67DB2
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Oct 2006 16:33:08 +1000 (EST)
Date: Wed, 4 Oct 2006 23:33:04 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 10/11] Add MPC8360EMDS board support
Message-ID: <20061005063304.GD1985@gate.ebshome.net>
References: <4879B0C6C249214CBE7AB04453F84E4D19D865@zch01exm20.fsl.freescale.net>
	<20060927165556.04c8d5d7@vitb.ru.mvista.com>
	<CE624A83-809E-4180-800E-660A578FFCFC@embeddedalley.com>
	<20060927112201.293fef44@localhost.localdomain>
	<EBD0615C-4F22-430F-BD23-1283DF98F1B3@embeddedalley.com>
	<1159942128.13323.21.camel@localhost.localdomain>
	<7BD0D5CE-7BA3-43DC-B972-B75672F6A31E@embeddedalley.com>
	<1160005019.5887.30.camel@localhost.localdomain>
	<20061005062105.GA1985@gate.ebshome.net>
	<1160029594.22232.22.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1160029594.22232.22.camel@localhost.localdomain>
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Oct 05, 2006 at 04:26:34PM +1000, Benjamin Herrenschmidt wrote:
> 
> Regarding the "mess", it's the whole #ifdef junk in there that is
> driving me nuts and that I'll rip appart probably next week. A lot of
> this could be soft-tests or the ifdefs could be resolved at Kconfig
> instead of having a list of processors in 3 different headers if you
> really want to compile the changes in rather than do soft-tests.

Well, sent me changes for review, or become a maintainer, but this 
time _real_ maintainer, not like last time when you touched this code.

-- 
Eugene

Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id 1D2AADDFB9
	for <linuxppc-dev@ozlabs.org>; Fri, 23 May 2008 01:16:30 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: 1 GB lowmem
Date: Thu, 22 May 2008 10:17:08 -0500
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B046E7CFE@ismail.innsys.innovsys.com>
In-Reply-To: <133B6911-6594-4366-9A0E-DF2604DFDA4C@kernel.crashing.org>
References: <DCEAAC0833DD314AB0B58112AD99B93B046E79B3@ismail.innsys.innovsys.com>
	<DCEAAC0833DD314AB0B58112AD99B93B046E7AA0@ismail.innsys.innovsys.com>
	<DCEAAC0833DD314AB0B58112AD99B93B046E7AF5@ismail.innsys.innovsys.com>
	<1941C6C3-9883-4015-91A6-35F5966AA1ED@kernel.crashing.org>
	<DCEAAC0833DD314AB0B58112AD99B93B046E7B25@ismail.innsys.innovsys.com>
	<133B6911-6594-4366-9A0E-DF2604DFDA4C@kernel.crashing.org>
From: "Rune Torgersen" <runet@innovsys.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> something like that would be good.  is there really anything PPC32
> specific about it?=20

Apparently. The Kconfig option is only available for arch/powerpc and
arch/ppc, and the only place in the whole codetree where
CONFIG_TASK_SIZE is used is that particular spot in
asm-powerpc/processor.h, and that again is within CONFIG_PPC32 define,
so it seems only PPC32 is using TASK_SIZE.

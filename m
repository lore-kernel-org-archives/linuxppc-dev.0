Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B29D7DDE24
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Feb 2007 08:04:08 +1100 (EST)
Subject: Re: [PATCH] Update udbg_progress() to display the integer
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mike Strosaker <strosake@austin.ibm.com>
In-Reply-To: <45C97121.9080609@austin.ibm.com>
References: <11707051151024-git-send-email-timur@freescale.com>
	<20070206013051.GA15525@lixom.net>	<45C90A6E.3040302@freescale.com>
	<17865.2853.132102.769702@cargo.ozlabs.ibm.com>
	<1170805102.2620.264.camel@localhost.localdomain>
	<45C91275.4020806@freescale.com>  <45C97121.9080609@austin.ibm.com>
Content-Type: text/plain
Date: Thu, 08 Feb 2007 08:03:46 +1100
Message-Id: <1170882226.2620.291.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Yeah, magic numbers suck, but the op panel does have some physical 
> constraints that prevent the printing of verbose messages.  These codes 
> could be mapped to useful messages in a file in Documentation/powerpc, 
> for example.

Or at least a .h with well defined constants instead of the current
mess :-)

Ben.

Return-Path: <apw@shadowen.org>
Received: from hellhawk.shadowen.org (hellhawk.shadowen.org [80.68.90.175])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "hellhawk.shadowen.org",
	Issuer "hellhawk.shadowen.org" (not verified))
	by ozlabs.org (Postfix) with ESMTP id D7A5968A78
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jan 2006 03:02:23 +1100 (EST)
Message-ID: <43C67B3F.3080301@shadowen.org>
Date: Thu, 12 Jan 2006 15:52:31 +0000
From: Andy Whitcroft <apw@shadowen.org>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
References: <20060112144437.GA15923@shadowen.org>
	<65FBDB60-D4A5-40DF-BA73-AB6388A9368B@kernel.crashing.org>
In-Reply-To: <65FBDB60-D4A5-40DF-BA73-AB6388A9368B@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: akpm@osdl.org, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc oprofile G4 clashes with wacom driver
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:

> How about a different prefix than POT_.  POT_ doesn't make me think  of
> PPC oprofile at all.  How about PPC_OPROFILE_ or POWERPC_OPROFILE_

Paul?  I am ambivalent about the prefix, and it can be trivially changed
to any that you feel approriate.

-apw

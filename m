Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 8D32C67B76
	for <linuxppc-dev@ozlabs.org>; Sun, 16 Jul 2006 13:54:31 +1000 (EST)
Date: Sat, 15 Jul 2006 22:53:54 -0500
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 0/3] powerpc: Instrument Hypervisor Calls
Message-ID: <20060716035353.GA5266@pb15.lixom.net>
References: <20060714233739.GA11487@monkey.ibm.com>
	<200607150200.03494.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200607150200.03494.arnd@arndb.de>
From: Olof Johansson <olof@lixom.net>
Cc: Bryan Rosenburg <rosnbrg@us.ibm.com>, linuxppc-dev@ozlabs.org,
	Nathan Lynch <ntl@pobox.com>, Paul Mackerras <paulus@samba.org>,
	Christopher Yeoh <cyeoh@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Jul 15, 2006 at 02:00:02AM +0200, Arnd Bergmann wrote:

> What happened to the question whether to use PURR values for also measuring
> cycles spent executing the hcall as opposed to cycles that passed before
> the hcall returns. Did that turn out not giving extra information after all
> or was there a different reason to drop that idea?

Just so people don't forget: this can't be done on all processors. For
example, PPC970 and POWER4 don't implement the PURR SPR. And it doesn't
make sense to use H_PURR to get the software emulated ones there. Not
really an issue on POWER4 since they don't do shared processor LPAR, but
on JS21 I think they might do?


-Olof

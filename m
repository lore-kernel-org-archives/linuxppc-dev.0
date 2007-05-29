Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id 3B3D5DE004
	for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2007 04:49:35 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Saving to 32 bits of GPRs in signal context
Date: Tue, 29 May 2007 20:48:21 +0200
References: <1180423456.19517.124.camel@localhost.localdomain>
	<200705291628.35852.arnd@arndb.de>
	<624dd5293b5fde0ffdf01ea692c32e9c@kernel.crashing.org>
In-Reply-To: <624dd5293b5fde0ffdf01ea692c32e9c@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200705292048.22569.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, Steve Munroe <sjmunroe@us.ibm.com>,
	Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
	Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 29 May 2007, Segher Boessenkool wrote:
> > right, as mentioned before, IP32L64 would imply introducing a new
> > ABI, which we don't want.
> 
> Hey, you could hijack the mswindows ABI, no need to
> define your own ;-)

Windows is IL32P64, not IP32L64

	Arnd <><

Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id 0B69FDDE39
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 09:56:40 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [RFC/PATCH] powerpc: Rewrite IO allocation & mapping on powerpc64
Date: Tue, 15 May 2007 01:56:32 +0200
References: <20070514075415.7999BDDEC8@ozlabs.org>
	<200705141637.19572.arnd@arndb.de>
	<850bd1e3d0b6c5e23a2fe43154591fd9@kernel.crashing.org>
In-Reply-To: <850bd1e3d0b6c5e23a2fe43154591fd9@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200705150156.32737.arnd@arndb.de>
Cc: Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 14 May 2007, Segher Boessenkool wrote:
> > Where should Olof's PCMCIA space go? The ISA or the PHB range?
> 
> It uses the legacy IDE I/O addresses, so it needs to
> go to the 64kB space. 

How so? All PCMCIA cards should get configured relative to
socket->io_offset. At least that is where the address used
in ide_cs.c comes from.

	Arnd <><

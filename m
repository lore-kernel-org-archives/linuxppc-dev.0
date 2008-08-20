Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18603.42058.670289.732716@cargo.ozlabs.ibm.com>
Date: Wed, 20 Aug 2008 14:57:46 +1000
From: Paul Mackerras <paulus@samba.org>
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH 4/8] powerpc: add the ability for a classic ppc kernel
	to be loaded at 32M
In-Reply-To: <20080801203819.GA27753@polina.dev.rtsoft.ru>
References: <20080801141306.GA29127@polina.dev.rtsoft.ru>
	<20080801141420.GD1161@polina.dev.rtsoft.ru>
	<20080801184952.GA25225@ld0162-tx32.am.freescale.net>
	<20080801203819.GA27753@polina.dev.rtsoft.ru>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Anton Vorontsov writes:

> > What do you do about the exception vectors?
> 
> Making a trampoline code in place of exception vectors. See this patch:
> 
> [PATCH 8/8] powerpc: last bits to support kdump on ppc32

It would probably be worth looking at whether we could do a
relocatable 32-bit kernel by linking it as a PIE and processing the
dynamic relocations at boot time (like the patches I posted recently
for 64-bit).

Paul.

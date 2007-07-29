Return-Path: <rjw@sisk.pl>
Received: from ogre.sisk.pl (ogre.sisk.pl [217.79.144.158])
	by ozlabs.org (Postfix) with ESMTP id 764AADDE02
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Jul 2007 07:45:44 +1000 (EST)
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Subject: Re: [PATCH] ppc: chipsfb.c build fix for CONFIG_PM
Date: Sun, 29 Jul 2007 23:33:11 +0200
References: <200707291950.30261.m.kozlowski@tuxland.pl>
In-Reply-To: <200707291950.30261.m.kozlowski@tuxland.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <200707292333.12766.rjw@sisk.pl>
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	paulus@samba.org, pavel@suse.cz, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sunday, 29 July 2007 19:50, Mariusz Kozlowski wrote:
> Hello,
> 
> 	This patch fixes the following build error on powerpc:
> 
>   CC      drivers/video/chipsfb.o
> drivers/video/chipsfb.c: In function 'chipsfb_pci_suspend':
> drivers/video/chipsfb.c:461: error: 'PM_SUSPEND_MEM' undeclared (first use in this function)
> drivers/video/chipsfb.c:461: error: (Each undeclared identifier is reported only once
> drivers/video/chipsfb.c:461: error: for each function it appears in.)
> make[2]: *** [drivers/video/chipsfb.o] Blad 1
> make[1]: *** [drivers/video] Blad 2
> make: *** [drivers] Blad 2

Already fixed in the right way.  Please see:
http://www.mail-archive.com/mm-commits@vger.kernel.org/msg22171.html

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth

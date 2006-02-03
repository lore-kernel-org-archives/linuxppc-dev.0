Return-Path: <olh@suse.de>
Received: from mx1.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 38B0A689F9
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Feb 2006 19:04:38 +1100 (EST)
Received: from Relay2.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id 00FB3EE50
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Feb 2006 09:04:34 +0100 (CET)
Date: Fri, 3 Feb 2006 09:04:33 +0100
From: Olaf Hering <olh@suse.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: spinlockup detection on POWER3
Message-ID: <20060203080433.GA6297@suse.de>
References: <20060122083826.GA5292@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20060122083826.GA5292@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 On Sun, Jan 22, Olaf Hering wrote:

> Does the CONFIG_DEBUG_SPINLOCK code  somehow depend on the cpu type?
> It triggers alot on a p270 POWER3 box, even during early boot. I dont 
> see it on POWE4/5.

> BUG: spinlock lockup on CPU#3, hotplug/1384, c000000000456900
...

this was cause by per_cpu data corruption.

-- 
short story of a lazy sysadmin:
 alias appserv=wotan

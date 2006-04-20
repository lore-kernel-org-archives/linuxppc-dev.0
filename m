Return-Path: <gerhard_pircher@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 3B3C067A3B
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Apr 2006 08:08:19 +1000 (EST)
Date: Fri, 21 Apr 2006 00:08:18 +0200 (MEST)
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
To: Eugene Surovegin <ebs@ebshome.net>
MIME-Version: 1.0
References: <20060420215514.GE25755@gate.ebshome.net>
Subject: Re: Not coherent cache DMA for G3/G4 CPUs: clarification needed
Message-ID: <1468.1145570898@www002.gmx.net>
Content-Type: text/plain; charset="iso-8859-1"
Cc: linuxppc-dev@ozlabs.org, debian-powerpc@lists.debian.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> --- Ursprüngliche Nachricht ---
> Von: Eugene Surovegin <ebs@ebshome.net>
> An: Gerhard Pircher <gerhard_pircher@gmx.net>
> Kopie: linuxppc-dev@ozlabs.org, debian-powerpc@lists.debian.org
> Betreff: Re: Not coherent cache DMA for G3/G4 CPUs: clarification needed
> Datum: Thu, 20 Apr 2006 14:55:14 -0700
> 
> Well, you aren't the first person who tries to run G4 with 
> CONFIG_NOT_COHERENT_CACHE. This was done before and I don't remember 
> that those people had to implement anything as complex as you are 
> trying to do.

Maybe these systems have cache coherent northbridges, which is not the case
for the AmigaOne and its "famous" ArticiaS northbridge.

> You can try asking on #mklinux. It always better to ask people who 
> actually _did_ this :).
> 
> In fact, I just grepped 2.6 and found 
> #ifdef(CONFIG_NOT_COHERENT_CACHE) in syslib/mv64x60.c. Guess what 
> systems usually have this type of bridge? Not 4xx/8xx, that's for sure.

Hmm, strange. AFAIK the NOT_COHERENT_CACHE config option is available only
for the 4xx and 8xx platforms. Wouldn't the config option depend on
CONFIG_6XX too, if there are not cache coherent systems with G4 cpus? 

At least I could not compile in the dma-mapping.c file without modifying the
Kconfig file.

> Good luck.

Thanks!

Gerhard

-- 
Analog-/ISDN-Nutzer sparen mit GMX SmartSurfer bis zu 70%!
Kostenlos downloaden: http://www.gmx.net/de/go/smartsurfer

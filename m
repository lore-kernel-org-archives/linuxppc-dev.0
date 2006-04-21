Return-Path: <gerhard_pircher@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 9F52F679F3
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Apr 2006 18:03:22 +1000 (EST)
Date: Fri, 21 Apr 2006 10:03:20 +0200 (MEST)
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
MIME-Version: 1.0
References: <1145594285.28014.12.camel@localhost.localdomain>
Subject: Re: Not coherent cache DMA for G3/G4 CPUs: clarification needed
Message-ID: <13431.1145606600@www025.gmx.net>
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
> Von: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> An: Eugene Surovegin <ebs@ebshome.net>
> Kopie: Gerhard Pircher <gerhard_pircher@gmx.net>,
> linuxppc-dev@ozlabs.org, debian-powerpc@lists.debian.org
> Betreff: Re: Not coherent cache DMA for G3/G4 CPUs: clarification needed
> Datum: Fri, 21 Apr 2006 14:38:05 +1000
> 
> > In fact, I just grepped 2.6 and found 
> > #ifdef(CONFIG_NOT_COHERENT_CACHE) in syslib/mv64x60.c. Guess what 
> > systems usually have this type of bridge? Not 4xx/8xx, that's for sure.
> 
> I think some folks tried ... and failed.
That doesn't sound encouraging. ;)

Gerhard

-- 
"Feel free" - 10 GB Mailbox, 100 FreeSMS/Monat ...
Jetzt GMX TopMail testen: http://www.gmx.net/de/go/topmail

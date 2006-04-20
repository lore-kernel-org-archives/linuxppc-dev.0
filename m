Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id E012B67A60
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Apr 2006 07:55:16 +1000 (EST)
Date: Thu, 20 Apr 2006 14:55:14 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Gerhard Pircher <gerhard_pircher@gmx.net>
Subject: Re: Not coherent cache DMA for G3/G4 CPUs: clarification needed
Message-ID: <20060420215514.GE25755@gate.ebshome.net>
References: <20060420210201.GA25755@gate.ebshome.net>
	<10026.1145567455@www088.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <10026.1145567455@www088.gmx.net>
Cc: linuxppc-dev@ozlabs.org, debian-powerpc@lists.debian.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Apr 20, 2006 at 11:10:55PM +0200, Gerhard Pircher wrote:
> Well, Freescale's PPC programming environment manual clearly states that
> this will not work on G4 CPUs (74xx). Also Benjamin Herrenschmidt told me,
> that this implementation will not work for the reasons I mentioned before. 
> The approach I'm trying to implement was his idea, so I have to trust in
> him.

Well, you aren't the first person who tries to run G4 with 
CONFIG_NOT_COHERENT_CACHE. This was done before and I don't remember 
that those people had to implement anything as complex as you are 
trying to do.

You can try asking on #mklinux. It always better to ask people who 
actually _did_ this :).

In fact, I just grepped 2.6 and found 
#ifdef(CONFIG_NOT_COHERENT_CACHE) in syslib/mv64x60.c. Guess what 
systems usually have this type of bridge? Not 4xx/8xx, that's for sure.

Good luck.

-- 
Eugene

Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5CB8EDE04D
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Jul 2007 22:09:31 +1000 (EST)
In-Reply-To: <1184368328.6059.271.camel@localhost.localdomain>
References: <20070704132212.726923000@pademelon.sonytel.be>
	<Pine.LNX.4.62.0707131541150.18802@pademelon.sonytel.be>
	<1184335333.3402.20.camel@localhost.localdomain>
	<200707131619.54898.arnd@arndb.de>
	<1184368328.6059.271.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <0A74AFF2-CBDA-4B00-AF5F-B6C6DACE0E16@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [patch 5/6] ps3: BD/DVD/CD-ROM Storage Driver
Date: Mon, 16 Jul 2007 14:08:57 +0200
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: James Bottomley <James.Bottomley@steeleye.com>,
	Arnd Bergmann <arnd@arndb.de>, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org, Alessandro Rubini <rubini@vision.unipv.it>,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Jens Axboe <jens.axboe@oracle.com>,
	Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> I'm pretty sure that no ppc64 machine needs alias resolution in  
>> the kernel,
>> although some are VIPT. Last time we discussed this, Segher  
>> explained it
>> to me, but I don't remember which way Cell does it. IIRC, it  
>> automatically
>> flushes cache lines that are accessed through aliases.
>
> Ah yes, I remember reading about this automatic flushing thing. I  
> don't
> know how the caches actually work on most of our PPC's, but the  
> fact is,
> we don't have aliasing issues, so I can safely ignore it for a bit
> longer :-)

That is the very short version of the story, yes: some
PowerPC implementations are VIPT physically, but there
are no aliasing issues we have to worry about.

Anyone interested in how this works, can download the
PPC970 UM (or 970FX or 970MP); it has a very detailed
explanation of all this.  Cell might be slightly different
but the base idea is the same.


Segher

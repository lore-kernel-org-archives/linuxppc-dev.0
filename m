Return-Path: <jochen@scram.de>
Received: from mail.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.scram.de", Issuer "scram e.V. CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 84D57DDEFE
	for <linuxppc-dev@ozlabs.org>; Thu, 15 May 2008 20:58:04 +1000 (EST)
Message-ID: <482C172B.1000600@scram.de>
Date: Thu, 15 May 2008 12:57:47 +0200
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>, akpm@linux-foundation.org,
	linuxppc-dev@ozlabs.org, paulus@samba.org
Subject: Re: [patch 2/4] powerpc: add i2c pins to dts and board setup
References: <200805142312.m4ENCrIb026259@imap1.linux-foundation.org>	<482B74D7.7080508@freescale.com>
	<20080515064753.GC30996@yookeroo.seuss>
In-Reply-To: <20080515064753.GC30996@yookeroo.seuss>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi David,

>> As I pointed out earlier, this patch is sticking dts-v0 style constants  
>> into a dts-v1 file.  It will not work.
> 
> Enough of this.  *Sends patch converting all remaining dts files to
> v1*.  With any luck we can merge that soon, and forget about the
> mistakes of v0 forever.

Many thanks :). I'll repost a fixed patch later.

Thanks,
Jochen

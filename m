Return-Path: <olh@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 469FF679F3
	for <linuxppc-dev@ozlabs.org>; Sat,  4 Mar 2006 02:27:54 +1100 (EST)
Received: from Relay2.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id C0DA61D638
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Mar 2006 16:27:49 +0100 (CET)
Date: Fri, 3 Mar 2006 16:27:49 +0100
From: Olaf Hering <olh@suse.de>
To: Andreas Schwab <schwab@suse.de>
Subject: Re: alignment bugs in prom_init
Message-ID: <20060303152749.GA6133@suse.de>
References: <20060303135717.GA5707@suse.de> <jefylz1tkh.fsf@sykes.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <jefylz1tkh.fsf@sykes.suse.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 On Fri, Mar 03, Andreas Schwab wrote:

> Olaf Hering <olh@suse.de> writes:
> 
> > sp is 0x0023e784, val is at offset 120, which makes 0x0023e7fc. This
> > address is casted to u32, which changes it to 0x0023e7f8.
> 
> Since when does casting to u32 cut off the low bits?

Way before gcc4.0 release at least.

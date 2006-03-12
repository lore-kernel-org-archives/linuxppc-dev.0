Return-Path: <olh@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id AF4AA679F0
	for <linuxppc-dev@ozlabs.org>; Sun, 12 Mar 2006 21:40:10 +1100 (EST)
Date: Sun, 12 Mar 2006 11:40:04 +0100
From: Olaf Hering <olh@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: enable NAP only on cpus who support it to avoid
	memory corruption
Message-ID: <20060312104004.GA26091@suse.de>
References: <20060311215840.GA22766@suse.de>
	<1142121302.4057.52.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1142121302.4057.52.camel@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 On Sun, Mar 12, Benjamin Herrenschmidt wrote:

> On Sat, 2006-03-11 at 22:58 +0100, Olaf Hering wrote:
> > commit 51d3082fe6e55aecfa17113dbe98077c749f724c enabled NAP unconditinally
> > on all powermacs. Early G3 cpus can not use it, the result is memory corruption.
> 
> Ok, here is what I think is a proper fix: Just remove the code from
> setup.c since feature.c will already set powersave_nap when needed.
> 
> Can you test asap please ? If it fixes the problem for you, I'll send
> the patch to Linus/Andrew with hopes that it will make it in 2.6.16 

Yes, this helps.

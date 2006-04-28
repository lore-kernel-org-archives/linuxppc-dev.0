Return-Path: <olh@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A6966679F0
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Apr 2006 21:19:47 +1000 (EST)
Date: Fri, 28 Apr 2006 13:19:42 +0200
From: Olaf Hering <olh@suse.de>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: alignment exceptionhandler sleeps in invalid context
Message-ID: <20060428111942.GA15646@suse.de>
References: <20060424173246.GA22318@suse.de>
	<17489.63055.968862.256370@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <17489.63055.968862.256370@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 On Fri, Apr 28, Paul Mackeras wrote:

> Olaf Hering writes:
> 
> > I'm not sure where the bug is. Does it mean the network stack does
> > something nasty, or is the exception handler itself broken? (probably the latter)
> > This is 2.6.16.9 on a p270.
> 
> This patch should fix it, I hope.  If you can verify that it fixes it
> I'll send it to Linus.

I dont have a testcase, it just happend once on the p270.

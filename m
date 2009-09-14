Return-Path: <avorontsov@ru.mvista.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id CC97DB7334
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 14 Sep 2009 23:59:04 +1000 (EST)
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 5DAC6DDD01
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Sep 2009 23:59:03 +1000 (EST)
Date: Mon, 14 Sep 2009 17:59:00 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: spa_kk <krishnakumar@spacomp.com>
Subject: Re: MPC8323 USB Host
Message-ID: <20090914135900.GA18534@oksana.dev.rtsoft.ru>
References: <25435195.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <25435195.post@talk.nabble.com>
Cc: linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

On Mon, Sep 14, 2009 at 05:49:01AM -0700, spa_kk wrote:
> 
> Hello,
[...]
> The value in this variable are not getting changed even after connecting &
> disconnection the device.

Could be pins multiplexing or USB clocks misconfiguration.

> We have manual checked the USBRXP pin, this pin is 
> HIGH => when device is connected
> LOW => when device is not connected.
>  
> Kindly let us know how should we debug/proceed.

You might find this useful:

http://lkml.org/lkml/2009/4/1/481

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2

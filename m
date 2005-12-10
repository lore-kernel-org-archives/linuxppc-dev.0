Return-Path: <olh@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 590F3688C7
	for <linuxppc-dev@ozlabs.org>; Sun, 11 Dec 2005 09:12:31 +1100 (EST)
Received: from Relay1.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id 74127E8D8
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Dec 2005 23:12:27 +0100 (CET)
Date: Sat, 10 Dec 2005 23:12:27 +0100
From: Olaf Hering <olh@suse.de>
To: linuxppc-dev@ozlabs.org
Message-ID: <20051210221226.GA22711@suse.de>
References: <20051210213632.GA21561@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20051210213632.GA21561@suse.de>
Subject: Re: ARCH=powerpc doesnt boot on 7200
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 On Sat, Dec 10, Olaf Hering wrote:

> My 7200 doesnt boot if the kernel runs at 32MB. It dies somewhere after turn_on_mmu().
> It boots ok if it runs at 7MB.  2.6.14 and earlier booted ok with 32MB.
> Any idea how to fix this? What does ARCH=powerpc different in this regard?

601 has only 16MB mapped after turn_on_mmu. I changed my zImage to start
claim at 5MB for this case, and it works again.

-- 
short story of a lazy sysadmin:
 alias appserv=wotan

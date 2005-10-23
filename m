Return-Path: <rupert@ces.ch>
Received: from server1.serv-net.de (31.204.203.213.rev.inetbone.net
	[213.203.204.31])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3B06B6856A
	for <linuxppc-dev@ozlabs.org>; Sun, 23 Oct 2005 19:21:09 +1000 (EST)
From: Rupert Eibauer <rupert@ces.ch>
To: Paul Mackerras <paulus@samba.org>
Date: Sun, 23 Oct 2005 11:36:51 +0200
References: <200510221554.03810.rupert@ces.ch>
	<17242.56232.293762.303684@cargo.ozlabs.ibm.com>
In-Reply-To: <17242.56232.293762.303684@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200510231136.51548.rupert@ces.ch>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH][RFT] Extended BAT features, take 2
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sunday 23 October 2005 02:39, Paul Mackerras wrote:
> Rupert Eibauer writes:
> 
> > What this patch actually does:
> > - Make CONFIG_PHYS_64BIT selectable for the 6xx family
> 
> Why?  What does this gain us?  

I have I/O resources there which are not reachable in 32 bit mode.

> We still can't use RAM above the 4GB point AFAICS.

Does this mean the page tables do not support 63 bit?

Rupert

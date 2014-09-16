Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0131.outbound.protection.outlook.com [157.56.110.131])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F17771A003D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Sep 2014 14:23:38 +1000 (EST)
Message-ID: <1410841400.24184.494.camel@snotra.buserror.net>
Subject: Re: Data Cache Push Parity Error
From: Scott Wood <scottwood@freescale.com>
To: <Jay_Chen@alphanetworks.com>
Date: Mon, 15 Sep 2014 23:23:20 -0500
In-Reply-To: <5538ce4d2de54f2fb7a29a66b33d70b0@HQMBS02.alphanetworks.com>
References: <5538ce4d2de54f2fb7a29a66b33d70b0@HQMBS02.alphanetworks.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2014-09-15 at 08:15 +0000, Jay_Chen@alphanetworks.com wrote:
> Hi all,
> 
>  
> 
> I am using P2020 with Linux kernel 3.8.13.
> 
> Sometimes my system encounters machine check exception and it shows
> “Caused by (from MCSR=20000000): Data Cache Push Parity Error”.
> 
> Could anyone show me some hints to dig into this issue? Any comment is
> welcome.
> 
> Thanks in advance.

I suggest contacting Freescale support about this
(support@freescale.com) -- I don't think this is the type of error that
you'd normally see from software misbehavior.

-Scott

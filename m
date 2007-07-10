Return-Path: <bzolnier@gmail.com>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.233])
	by ozlabs.org (Postfix) with ESMTP id 1CBCCDDEBF
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 08:04:47 +1000 (EST)
Received: by wx-out-0506.google.com with SMTP id h27so1189916wxd
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jul 2007 15:04:46 -0700 (PDT)
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] ide: Use inline function for eieio
Date: Tue, 10 Jul 2007 23:58:37 +0200
References: <Pine.LNX.4.64.0707100018020.5814@blarg.am.freescale.net>
	<469384B3.1080502@ru.mvista.com>
In-Reply-To: <469384B3.1080502@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200707102358.37236.bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


[ added Kou back to cc: ]

On Tuesday 10 July 2007, Sergei Shtylyov wrote:
> Hello.
> 
> Kumar Gala wrote:
> > Move to using inline function variant of eieio instead of inline assmebly.
> 
> > Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

applied

Please use host driver name ("scc_pata" in this case) instead of "ide" in
the patch summary if your changes are limited to a single host driver.

This helps later when going through git logs.

> Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

added

Thanks,
Bart

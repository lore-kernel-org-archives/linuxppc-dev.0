Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rlhhj6bMRzDr0F
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jul 2016 01:42:44 +1000 (AEST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@lists.ozlabs.org
Cc: Arvind Yadav <arvind.yadav.cs@gmail.com>, leoli@freescale.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Removing lots of IS_ERR_VALUE abuses and compilation
 warning.
Date: Thu, 07 Jul 2016 17:45:53 +0200
Message-ID: <3262228.FZLtnpegJr@wuerfel>
In-Reply-To: <1467904336-3588-1-git-send-email-arvind.yadav.cs@gmail.com>
References: <1467904336-3588-1-git-send-email-arvind.yadav.cs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thursday, July 7, 2016 8:42:16 PM CEST Arvind Yadav wrote:
>     Passing value in IS_ERR_VALUE() is wrong, as they
>     pass an 'int' into a function that takes an 'unsigned long'
>     argument. This happens to work because the type is sign-extended
>     on 64-bit architectures before it gets converted into an
>     unsigned type.
> 
>     Passing an 'unsigned short' or 'unsigned int'
>     argument into IS_ERR_VALUE() is guaranteed to be broken, as are
>     8-bit integers and types that are wider than 'unsigned long'.
> 
>     Any user will get compilation warning for that do not pass an
>     'unsigned long' argument.
> 
>     Commit '287980e49f; - This change is alreday fixes lots of other
>     worst abusers.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> 

Acked-by: Arnd Bergmann <arnd@arndb.de>

just notice about your submission that the changelog is whitespace
damaged, you probably got the leading whitespace when you pasted
a git log into the commit.

	Arnd

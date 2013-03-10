Return-Path: <gang.chen@asianux.com>
Received: from intranet.asianux.com (intranet.asianux.com [58.214.24.6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 440422C0324
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 Mar 2013 12:19:15 +1100 (EST)
Message-ID: <513BDF78.80005@asianux.com>
Date: Sun, 10 Mar 2013 09:18:48 +0800
From: Chen Gang <gang.chen@asianux.com>
MIME-Version: 1.0
To: David Laight <David.Laight@ACULAB.COM>
Subject: Re: [PATCH] drivers/tty/hvc: fixup original commit:
 9276dfd27897a0b29d8b5814f39a1f82f56b6b6b
References: <512C2F5D.1080207@asianux.com> <512F343E.7010201@suse.cz>
 <512F3BC5.8020903@asianux.com> <512F3C60.9070409@asianux.com>
 <512F5FDC.3060000@suse.cz> <51355142.4070505@asianux.com>
 <5135BCAB.5040500@suse.cz> <51381352.9090803@asianux.com>
 <513818EC.9050504@asianux.com> <1362636305.3548.58.camel@pasglop>
 <51395D2C.6040007@asianux.com> <1362714364.6977.4.camel@pasglop>
 <AE90C24D6B3A694183C094C60CF0A2F6026B7182@saturn3.aculab.com>
In-Reply-To: <AE90C24D6B3A694183C094C60CF0A2F6026B7182@saturn3.aculab.com>
Content-Type: text/plain; charset=GB2312
Cc: Jiri Slaby <jslaby@suse.cz>, wfp5p@virginia.edu,
 Greg KH <gregkh@linuxfoundation.org>, tklauser@distanz.ch,
 linuxppc-dev@lists.ozlabs.org, alan@linux.intel.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

于 2013年03月08日 19:11, David Laight 写道:
> Using strlcpy() also stops someone else having to check it
> again in a few years time.

  yes.

  :-)

-- 
Chen Gang

Asianux Corporation

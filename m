Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 6723D2C0373
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Mar 2013 16:08:52 +1100 (EST)
Message-ID: <1362719285.6977.6.camel@pasglop>
Subject: Re: [PATCH] drivers/tty/hvc: fixup original commit:
 9276dfd27897a0b29d8b5814f39a1f82f56b6b6b
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Chen Gang <gang.chen@asianux.com>
Date: Fri, 08 Mar 2013 16:08:05 +1100
In-Reply-To: <51396BAA.2030307@asianux.com>
References: <512C2F5D.1080207@asianux.com> <512F343E.7010201@suse.cz>
 <512F3BC5.8020903@asianux.com> <512F3C60.9070409@asianux.com>
 <512F5FDC.3060000@suse.cz> <51355142.4070505@asianux.com>
 <5135BCAB.5040500@suse.cz> <51381352.9090803@asianux.com>
 <513818EC.9050504@asianux.com> <1362636305.3548.58.camel@pasglop>
 <51395D2C.6040007@asianux.com> <1362714364.6977.4.camel@pasglop>
 <513967BC.2030301@asianux.com> <1362717201.6977.5.camel@pasglop>
 <51396BAA.2030307@asianux.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Greg KH <gregkh@linuxfoundation.org>, linuxppc-dev@lists.ozlabs.org,
 wfp5p@virginia.edu, tklauser@distanz.ch, Jiri Slaby <jslaby@suse.cz>,
 alan@linux.intel.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2013-03-08 at 12:40 +0800, Chen Gang wrote:
>   is it correct ?

Yes, the code is fine as it is now.

Ben.

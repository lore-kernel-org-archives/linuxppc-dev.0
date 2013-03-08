Return-Path: <gang.chen@asianux.com>
Received: from intranet.asianux.com (intranet.asianux.com [58.214.24.6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id BE1BA2C0376
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Mar 2013 15:40:36 +1100 (EST)
Message-ID: <51396BAA.2030307@asianux.com>
Date: Fri, 08 Mar 2013 12:40:10 +0800
From: Chen Gang <gang.chen@asianux.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] drivers/tty/hvc: fixup original commit:
 9276dfd27897a0b29d8b5814f39a1f82f56b6b6b
References: <512C2F5D.1080207@asianux.com> <512F343E.7010201@suse.cz>
 <512F3BC5.8020903@asianux.com> <512F3C60.9070409@asianux.com>
 <512F5FDC.3060000@suse.cz> <51355142.4070505@asianux.com>
 <5135BCAB.5040500@suse.cz> <51381352.9090803@asianux.com>
 <513818EC.9050504@asianux.com> <1362636305.3548.58.camel@pasglop>
 <51395D2C.6040007@asianux.com> <1362714364.6977.4.camel@pasglop>
 <513967BC.2030301@asianux.com> <1362717201.6977.5.camel@pasglop>
In-Reply-To: <1362717201.6977.5.camel@pasglop>
Content-Type: text/plain; charset=UTF-8
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

于 2013年03月08日 12:33, Benjamin Herrenschmidt 写道:
> On Fri, 2013-03-08 at 12:23 +0800, Chen Gang wrote:
>> >   really it is: using strlcpy doesn't hurt.
>> > 
>> >   the comments and subject of original commit are not quite precision:
>> >     it is not for a bug issue (originally I say it is for bug issue)
>> >     it is really for beautify code.
>> > 
>> >   can I send a fixup patch only for the comments ?
> No just drop it, it's fine as it is.

  I guess your meaning is:
    not need additional fix up patch (just drop it).
    original commit 9276dfd27897a0b29d8b5814f39a1f82f56b6b6b is valid
      (not need drop the original commit)

  is it correct ?

  thanks.

-- 
Chen Gang

Asianux Corporation

Return-Path: <gang.chen@asianux.com>
Received: from intranet.asianux.com (intranet.asianux.com [58.214.24.6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 362132C0361
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Mar 2013 18:10:37 +1100 (EST)
Message-ID: <51383D52.6000801@asianux.com>
Date: Thu, 07 Mar 2013 15:10:10 +0800
From: Chen Gang <gang.chen@asianux.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] drivers/tty/hvc: using strlcpy instead of strncpy
References: <512C2F5D.1080207@asianux.com> <512F343E.7010201@suse.cz>
 <512F3BC5.8020903@asianux.com> <512F3C60.9070409@asianux.com>
 <512F5FDC.3060000@suse.cz> <51355142.4070505@asianux.com>
 <5135BCAB.5040500@suse.cz> <51381352.9090803@asianux.com>
 <513818EC.9050504@asianux.com> <1362636305.3548.58.camel@pasglop>
In-Reply-To: <1362636305.3548.58.camel@pasglop>
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

于 2013年03月07日 14:05, Benjamin Herrenschmidt 写道:
> On Thu, 2013-03-07 at 12:34 +0800, Chen Gang wrote:
>> >   oh, this patch has integrated into next-20130307 tree.
>> >     (commit 9276dfd27897a0b29d8b5814f39a1f82f56b6b6b)
>> >   it seems we need a regression for this commit, then I send patch v2
>> > 
>> >   is it correct ?
> Just send a fixup patch on top of the existing upstream.

  ok, thanks.

  :-)

-- 
Chen Gang

Asianux Corporation

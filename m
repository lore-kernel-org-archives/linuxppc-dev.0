Return-Path: <runaway@candw.ms>
Received: from mail-vc0-f170.google.com (mail-vc0-f170.google.com
 [209.85.220.170])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0BBC71A1047
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Feb 2015 21:30:23 +1100 (AEDT)
Received: by mail-vc0-f170.google.com with SMTP id hq12so9640903vcb.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Feb 2015 02:30:20 -0800 (PST)
From: Julian Margetson <runaway@candw.ms>
To: Michael Ellerman <mpe@ellerman.id.au>
Date: Mon, 23 Feb 2015 22:22:32 -0400 (AST)
Message-ID: <45df690866b.32811198@smtp.gmail.com>
In-Reply-To: <1424737962.2318.2.camel@ellerman.id.au>
References: <54E08E06.8060607@candw.ms>
 <1424045921.3018.4.camel@ellerman.id.au> <54E4EBD7.5000307@candw.ms>
 <1424304787.22020.4.camel@ellerman.id.au> <54E53E07.60609@candw.ms>
 <1424314594.22408.1.camel@ellerman.id.au> <54E55796.6000401@candw.ms>
 <54E78A12.7080409@candw.ms> <1424737962.2318.2.camel@ellerman.id.au>
Subject: Re: Problems with Kernels 3.17-rc1 and onwards on Acube Sam460
 AMCC 460ex board
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org, Ian Munsie <imunsie@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I had  a hanging Uboot problem with a Sam440ep board.Never figured the problem out but
It workedd for another two years after the problems began. Died for good last September with the hanging becoming  a daily issue.
Dont think that it was overheating. I thought that it could have been a problem with  the on board  ethernet.

anyway I am still not giving up hopes of DRI and future kernals working, only into my second year of trying so too soon to give up .
Doing a git bisect on the 4.00-rc1 now.

On 02/24/2015, you wrote:

> On Fri, 2015-02-20 at 15:25 -0400, Julian Margetson wrote:
>> On 2/18/2015 11:25 PM, Julian Margetson wrote:
>
>>  re PPC4XX PCI(E) MSI support.
>> https://lists.ozlabs.org/pipermail/linuxppc-dev/2010-November/087273.html
>
> Hmm, I think all those comments were addressed before it was merged.
>
> I tried to get a 4xx board going here last week, but it doesn't seem happy. I
> can get a bit of uboot but then it hangs, might be overheating.
>
> cheers
>
>

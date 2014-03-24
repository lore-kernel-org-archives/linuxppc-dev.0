Return-Path: <clg@fr.ibm.com>
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 1F4CD2C00BA
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Mar 2014 19:38:17 +1100 (EST)
Received: from /spool/local
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clg@fr.ibm.com>;
 Mon, 24 Mar 2014 08:38:13 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 866F017D8047
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Mar 2014 08:38:56 +0000 (GMT)
Received: from d06av06.portsmouth.uk.ibm.com (d06av06.portsmouth.uk.ibm.com
 [9.149.37.217])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s2O8bx5U61735138
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Mar 2014 08:37:59 GMT
Received: from d06av06.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av06.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s2O9cBsd031011
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Mar 2014 03:38:11 -0600
Message-ID: <532FEEF0.40607@fr.ibm.com>
Date: Mon, 24 Mar 2014 09:38:08 +0100
From: Cedric Le Goater <clg@fr.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 18/18] powerpc/boot: add PPC64_BOOT_WRAPPER config option
References: <1395328213-19206-1-git-send-email-clg@fr.ibm.com>
 <1395328213-19206-19-git-send-email-clg@fr.ibm.com>
 <1395632548.3460.135.camel@pasglop>
In-Reply-To: <1395632548.3460.135.camel@pasglop>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Benjamin,

> So I originally applied all 3 last patches of the series as one
> (collapsed them in git) in order to not break bisection.
> 
> However, I had to take the series out in the end due to it
> causing this error on some of my test configs:
> 
> powerpc64-linux-ld: cannot find arch/powerpc/boot/pseries-head.o: No such file or directory
>
> I haven't had a chance to investigate yet, but sadly it looks like
> this series might have to wait for the next round.

OK. I will take a look. 

Thanks,

C.

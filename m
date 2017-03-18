Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x22b.google.com (mail-pg0-x22b.google.com
 [IPv6:2607:f8b0:400e:c05::22b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vlhml4zqmzDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Mar 2017 23:47:03 +1100 (AEDT)
Received: by mail-pg0-x22b.google.com with SMTP id b129so55595998pgc.2
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Mar 2017 05:47:03 -0700 (PDT)
Date: Sat, 18 Mar 2017 22:46:50 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Christian Zigotzky <chzigotzky@xenosoft.de>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/pasemi, cbe: Do not process decremeter or
 external wakeup from powersave
Message-ID: <20170318224650.4f69a31f@roar.ozlabs.ibm.com>
In-Reply-To: <b17775f4-a2c5-ede6-33e3-6f6722a31d6e@xenosoft.de>
References: <b17775f4-a2c5-ede6-33e3-6f6722a31d6e@xenosoft.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 17 Mar 2017 15:43:22 +0100
Christian Zigotzky <chzigotzky@xenosoft.de> wrote:

> Nicholas Piggin <npiggin at gmail.com> writes:
> 
>  > Hi,
>  >
>  > I would like to start using a dedicated stack for system reset interrupt
>  > and treat it as a Linux nmi, which makes it tricky to call complex
>  > interrupt handlers directly from the system reset trap handler.
>  >
>  > So I would like to remove the decrementer and external handler calls from
>  > Cell and Pasemi platforms' system reset handler. I think we can just
>  > remove them if they can be handled when they re-fire as normal   
> interrupts?
>  > At the moment I don't have environments set up to test if this works.  
> 
> 
> It works fine with my AmigaOne X1000. (Nemo board with a P.A. Semi  
> PA6T-1682M CPU)

Thanks for testing, that's very useful. I will add your tested-by line
for the pasemi part of the patch.

Thanks,
Nick

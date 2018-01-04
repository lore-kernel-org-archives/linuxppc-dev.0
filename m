Return-Path: <msuchanek@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zCLV50Dm0zDqmy
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Jan 2018 08:27:08 +1100 (AEDT)
Date: Thu, 4 Jan 2018 22:27:04 +0100
From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To: Christian Zigotzky <chzigotzky@xenosoft.de>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: Spectre+Meltdown
Message-ID: <20180104222704.5a9b490d@naga.suse.cz>
In-Reply-To: <36E75811-C758-49B1-8E5C-3A2C44FD5DE9@xenosoft.de>
References: <36E75811-C758-49B1-8E5C-3A2C44FD5DE9@xenosoft.de>
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

Hello,

On Thu, 4 Jan 2018 16:09:34 +0100
Christian Zigotzky <chzigotzky@xenosoft.de> wrote:

> Hi All,
> 
> Do we have some information regarding Spectre+Meltdown for our users?
> 
> It could be that we have some security issues in our PowerPC CPUs.
> 
> Links:
> 
> https://www.phoronix.com/scan.php?page=news_item&px=Linux-Kernel-Retpoline-Patches
> 
> https://www.phoronix.com/scan.php?page=news_item&px=x86-PTI-EPYC-Linux-4.15-Test
> 

Since the vulnerability details were disclosed already you should see
patches addressing it in your local kernel git repository. AFAICT some
patches for preventing speculative execution in some random parts of
the kernel as well as adding an extra flush when returning from kernel
to userspace are applicable to powerpc.

I am not familiar with all the details so you are free to investigate
the code for yourself or fish some article from someone who really
knows what the thing is all about and how it affects powerpc in
particular.

Thanks

Michal

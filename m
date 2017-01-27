Return-Path: <darren@stevens-zone.net>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v8zYD3H4GzDqXf
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Jan 2017 00:05:36 +1100 (AEDT)
From: Darren Stevens <darren@stevens-zone.net>
To: Michael Ellerman <patch-notifications@ellerman.id.au>
CC: linuxppc-dev@lists.ozlabs.org, Pat Wall <pjwall@mac.com>, rtd@a-eon.com,
 aperez@alexperez.com, Christian Zigotzky <chzigotzky@xenosoft.de>
Date: Fri, 27 Jan 2017 13:05:12 +0000 (GMT)
Message-ID: <497f067c261.255bb3a2@auth.smtp.1and1.co.uk>
In-Reply-To: <3v8frs0RLyz9t1B@ozlabs.org>
References: <497a1d88a93.7082e0e9@auth.smtp.1and1.co.uk>
 <3v8frs0RLyz9t1B@ozlabs.org>
Subject: Re: powerpc: Add missing error check to prom_find_boot_cpu()
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Michael

On 27/01/2017, Michael Ellerman wrote:
> On Mon, 2017-01-23 at 19:42:54 UTC, Darren Stevens wrote:
> Applied to powerpc fixes, thanks.
>
> https://git.kernel.org/powerpc/c/af2b7fa17eb92e52b65f96604448ff

Thanks, I was going to ask about backporting to 4.9 as it's a LTS now, but I
see from the above you've beaten me to it! Much appreciated.

I'm nearing the point where I will want to add the Nemo setup code to the
kernel, and I see 2 choices: 

Continue as we do, with #ifdefs in the setup.c / pci.c files.

Create 2 new files setup-nemo.c and pci-nemo.c - I am assuming this would be
the prefered option?

Regards
Darren

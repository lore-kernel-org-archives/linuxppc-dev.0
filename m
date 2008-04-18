Return-Path: <neko@genesi-usa.com>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.30])
	by ozlabs.org (Postfix) with ESMTP id 80EA1DE619
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Apr 2008 01:34:29 +1000 (EST)
Received: by yw-out-2324.google.com with SMTP id 3so396163ywj.39
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Apr 2008 08:34:14 -0700 (PDT)
Message-ID: <4808BF66.3020803@genesi-usa.com>
Date: Fri, 18 Apr 2008 16:33:58 +0100
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [EFIKA] Really, don't pretend to be CHRP
References: <1208105558.3026.137.camel@pmac.infradead.org>	
	<4807427B.3030902@genesi-usa.com>	
	<1208443057.9212.250.camel@pmac.infradead.org>	
	<48076A00.1080608@genesi-usa.com>
	<1208450247.9212.275.camel@pmac.infradead.org>
In-Reply-To: <1208450247.9212.275.camel@pmac.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: Matt Sealey <neko@genesi-usa.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


David Woodhouse wrote:
> OTOH, it probably wouldn't be _so_ hard to port Mitch's OpenFirmware to
> mpc5200...

Go for it.

I also give you permission to detail how our firmware is a bit crap in
the Fedora release notes. You will have to do that anyway to evangelize
the weird setenv hack you just proposed, so it will kill two birds with
one stone.

Also regarding your original patch; why not just fix the cpuinfo printout
so that it doesn't print the machine/vendor properties from firmware.

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=arch/powerpc/platforms/52xx/efika.c;h=a2068faef6ea9c7b5b4fb2db804a32f33e1598b1;hb=HEAD#l155

It's right there. I'd rather they were taken out than putting MORE
property changes into fixups.

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations

Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2841068A12
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Jan 2006 10:17:00 +1100 (EST)
Subject: Re: [Alsa-devel] RFC: OSS driver removal, a slightly different
	approach
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olaf Hering <olh@suse.de>
In-Reply-To: <20060120212917.GA14405@suse.de>
References: <20060119174600.GT19398@stusta.de>
	<20060120115443.GA16582@palantir8> <20060120190415.GM19398@stusta.de>
	<20060120212917.GA14405@suse.de>
Content-Type: text/plain
Date: Sat, 21 Jan 2006 10:16:40 +1100
Message-Id: <1137799001.12998.59.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org,
	Ben Collins <ben.collins@ubuntu.com>,
	linux-kernel@vger.kernel.org, Adrian Bunk <bunk@stusta.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2006-01-20 at 22:29 +0100, Olaf Hering wrote:
>  On Fri, Jan 20, Adrian Bunk wrote:
> 
>  
> > Can someone from the ppc developers drop me a small note whether 
> > SND_POWERMAC completely replaces DMASOUND_PMAC?
> 
> It doesnt. Some tumbler models work only after one plug/unplug cycle of
> the headphone. early powerbooks report/handle the mute settings
> incorrectly. there are likely more bugs.

Interesting... Ben Collins hacked something to have Toonie work as a
"default" driver for non supported machine and saw that problem too, I
think he fixes it, I'll check with him what's up there and if his fix
applied to tumbler.c as well.

Ben.

Return-Path: <matt@genesi-usa.com>
Received: from mail.genesi-usa.com (mithrandir.softwarenexus.net
	[66.98.186.96])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5D90BDDE36
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Aug 2007 02:45:22 +1000 (EST)
Message-ID: <46BB44E6.4050308@genesi-usa.com>
Date: Thu, 09 Aug 2007 17:46:30 +0100
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Pegasos keyboard detection
References: <200708020440.l724edCT290676@shell01.TheWorld.com>
	<46B79562.9020202@genesi-usa.com>
	<f4545a576abeddf00f076a0cae9e3fdd@kernel.crashing.org>
	<46B89C10.7090507@genesi-usa.com>
	<909c5e405e5cd26bca3aff13fe55adbc@kernel.crashing.org>
In-Reply-To: <909c5e405e5cd26bca3aff13fe55adbc@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, Alan Curry <pacman@TheWorld.com>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Segher Boessenkool wrote:
>> Would you guys rather we shipped a boot script that ran the OS, fixed
>> all these issues in-place in-firmware, so Linux did not have to have 
>> these
>> workarounds,
> 
> Sure, if you can do that, that would be great.

Right, so don't accept that keyboard fix, and we will work on the script
instead.

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations

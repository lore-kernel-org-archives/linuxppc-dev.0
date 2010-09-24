Return-Path: <khali@linux-fr.org>
Received: from services.gcu-squad.org (zone0.gcu-squad.org [212.85.147.21])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CCB80B70FE
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 24 Sep 2010 21:39:51 +1000 (EST)
Date: Fri, 24 Sep 2010 13:39:32 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Mikael Pettersson <mikpe@it.uu.se>, Grant Likely
	<grant.likely@secretlab.ca>
Subject: Re: [BUG 2.6.36-rc5] of_i2c.ko <-> i2c-core.ko dependency loop
Message-ID: <20100924133932.4320b993@endymion.delvare>
In-Reply-To: <19612.33369.175358.879889@pilspetsen.it.uu.se>
References: <19611.16302.262307.129176@pilspetsen.it.uu.se>
	<20100923113807.4643fbbb.rdunlap@xenotime.net>
	<19611.46496.782340.466509@pilspetsen.it.uu.se>
	<20100923150559.9c67da11.rdunlap@xenotime.net>
	<20100924111209.3c071da3@endymion.delvare>
	<19612.33369.175358.879889@pilspetsen.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Randy Dunlap <rdunlap@xenotime.net>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Mikael,

On Fri, 24 Sep 2010 12:50:01 +0200, Mikael Pettersson wrote:
> Jean Delvare writes:
>  > As far as I can see this is caused by this commit from Grant:
>  > 
>  > http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=959e85f7751c33d1a2dabc5cc3fe2ed0db7052e5
>  > 
>  > Mikael, can you please try reverting this patch and see if it solves
>  > your problem?
> 
> Yes, reverting the above commit from 2.6.36-rc5 eliminated the warnings,
> and I was able to insmod the i2c-{core,dev,powermac}.ko modules.

Thanks for testing and reporting. Grant, unless you come up with a fix
very quickly, I'll have to revert
959e85f7751c33d1a2dabc5cc3fe2ed0db7052e5 for 2.6.36.

-- 
Jean Delvare

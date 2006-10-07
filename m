Return-Path: <SRS0+515ad6c77a5c8ff5a49c+1140+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 05A6567E69
	for <linuxppc-dev@ozlabs.org>; Sun,  8 Oct 2006 01:10:30 +1000 (EST)
Subject: Re: vsdo_datapage.h WTF?
From: David Woodhouse <dwmw2@infradead.org>
To: Anton Blanchard <anton@samba.org>
In-Reply-To: <20061007145811.GA4043@krispykreme>
References: <1160148208.4795.30.camel@pmac.infradead.org>
	<1160170374.22232.135.camel@localhost.localdomain>
	<20061007145811.GA4043@krispykreme>
Content-Type: text/plain
Date: Sat, 07 Oct 2006 16:10:17 +0100
Message-Id: <1160233817.4795.85.camel@pmac.infradead.org>
Mime-Version: 1.0
Cc: paulus@samba.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 2006-10-08 at 00:58 +1000, Anton Blanchard wrote:
> We need a way to export cache size/associativity information (sysfs,
> /proc/device-tree parsing?) and a plan to fix the applications using
> it first. 

ELF auxvec?

-- 
dwmw2

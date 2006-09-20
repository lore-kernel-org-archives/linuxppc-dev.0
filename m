Return-Path: <mgreer@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id 9617B67B5D
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Sep 2006 11:27:57 +1000 (EST)
Date: Tue, 19 Sep 2006 18:28:43 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] Start arch/powerpc/boot code reorganization
Message-ID: <20060920012843.GA29635@mag.az.mvista.com>
References: <17680.30367.157642.674242@cargo.ozlabs.ibm.com>
	<20060920012042.GA28489@mag.az.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060920012042.GA28489@mag.az.mvista.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Sep 19, 2006 at 06:20:42PM -0700, Mark A. Greer wrote:
> Paul,
> 
> Regarding our earlier conversation about ft_translate_addr and
...

BTW, the only changes to your patch would be removing translate_addr from
dt_ops in ops.h and removing the "dt_ops.translate_addr = NULL;" line
in of.c.

I'll respin the other patches.

Mark

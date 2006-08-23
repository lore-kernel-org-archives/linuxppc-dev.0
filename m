Return-Path: <olaf@ibook.aepfle.de>
Received: from natlemon.rzone.de (natlemon.rzone.de [81.169.145.170])
	by ozlabs.org (Postfix) with ESMTP id 12FB067D23
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Aug 2006 16:08:22 +1000 (EST)
Date: Wed, 23 Aug 2006 08:08:15 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] update pmac32_defconfig
Message-ID: <20060823060815.GA9071@aepfle.de>
References: <20060821124323.GA28970@aepfle.de>
	<17643.60111.162041.406187@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <17643.60111.162041.406187@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Aug 23, Paul Mackerras wrote:

> Olaf Hering writes:
> 
> > enable windfarm, pppoe, pegasus, Euro nls and magic sysrq.
> 
> Why windfarm?  It doesn't do anything useful on 32-bit machines, not
> yet anyway...

I was under the impression that some G4 use this driver.

Return-Path: <joern@wohnheim.fh-wedel.de>
Received: from wohnheim.fh-wedel.de (wohnheim.fh-wedel.de [213.39.233.138])
	by ozlabs.org (Postfix) with ESMTP id 7A14F67A2E
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Apr 2006 22:57:30 +1000 (EST)
Date: Thu, 27 Apr 2006 14:57:26 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Heiko J Schick <schihei@de.ibm.com>
Subject: Re: [PATCH 00/16] ehca: IBM eHCA InfiniBand Device Driver
Message-ID: <20060427125726.GK32127@wohnheim.fh-wedel.de>
References: <4450B378.9000705@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <4450B378.9000705@de.ibm.com>
Cc: schickhj@de.ibm.com, linux-kernel@vger.kernel.org,
	openib-general@openib.org, linuxppc-dev@ozlabs.org,
	Christoph Raisch <RAISCH@de.ibm.com>,
	Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>, Marcus Eder <MEDER@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 27 April 2006 14:05:12 +0200, Heiko J Schick wrote:
> 
> many thanks for your comments. They are very helpful for us. All
> 17 patches have to be applied, otherwise the driver won't compile.

Don't expect much cheer and rejoicing over this.  I suspect that akpm
or Linus will either want the 17 patches merged into one or have a
patchset where every single patch leaves the kernel in a working
state, including working eHCA driver.

Generally, there seemed to be a bit more SHOUTING when compared to
other kernel code.  Might be something to look at as well.

Jörn

-- 
Rules of Optimization:
Rule 1: Don't do it.
Rule 2 (for experts only): Don't do it yet.
-- M.A. Jackson 

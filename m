Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao04.cox.net (fed1rmmtao04.cox.net [68.230.241.35])
	by ozlabs.org (Postfix) with ESMTP id 4A73667B1C
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  8 Apr 2005 08:57:34 +1000 (EST)
Date: Thu, 7 Apr 2005 15:57:33 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Eduardo Munoz <eamunoz@us.ibm.com>
Message-ID: <20050407225733.GU3396@smtp.west.cox.net>
References: <OFBEBF187E.5BDC9AA1-ON87256FDC.006D71EC-86256FDC.006E4252@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <OFBEBF187E.5BDC9AA1-ON87256FDC.006D71EC-86256FDC.006E4252@us.ibm.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: undefined reference to `zs_kgdb_
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Apr 07, 2005 at 02:58:16PM -0500, Eduardo Munoz wrote:

> Hey!!
> 
> I am trying to compile my ppc  kernel 2.6 with KGDB enable and it fails
> with the following message:
> 
> LD      .tmp_vmlinux1
> arch/ppc/platforms/built-in.o(.init.text+0xfc4): In function
> `pmac_setup_arch':
> arch/ppc/platforms/pmac_setup.c:301: undefined reference to `zs_kgdb_hook'
> make: *** [.tmp_vmlinux1] Error 1
> error: Bad exit status from /var/tmp/rpm-tmp.40235 (%build)

KGDB is not supported on PPC_MULTIPLATFORM.  If you want something like
pegasos you might be able to kludge in arch/ppc/syslib/gen550_* so that
you can get it working for you, however.

-- 
Tom Rini
http://gate.crashing.org/~trini/

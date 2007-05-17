Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0B702DDEE6
	for <linuxppc-dev@ozlabs.org>; Thu, 17 May 2007 11:26:47 +1000 (EST)
Subject: Re: [PATCH] [POWERPC] remove build warnings in windfarm_core
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20070517112215.6261992d.sfr@canb.auug.org.au>
References: <20070514163219.9d78cde0.sfr@canb.auug.org.au>
	<17993.20745.432703.238649@cargo.ozlabs.ibm.com>
	<20070516112449.9f0ae1a2.sfr@canb.auug.org.au>
	<20070517112215.6261992d.sfr@canb.auug.org.au>
Content-Type: text/plain
Date: Thu, 17 May 2007 11:26:33 +1000
Message-Id: <1179365193.32247.254.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-05-17 at 11:22 +1000, Stephen Rothwell wrote:
> drivers/macintosh/windfarm_core.c: In function 'wf_register_control':
> drivers/macintosh/windfarm_core.c:219: warning: ignoring return value of 'device_create_file', declared with attribute warn_unused_result
> drivers/macintosh/windfarm_core.c: In function 'wf_register_sensor':
> drivers/macintosh/windfarm_core.c:329: warning: ignoring return value of 'device_create_file', declared with attribute warn_unused_result
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

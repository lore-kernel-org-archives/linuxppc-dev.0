Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id ED992679FF
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Feb 2006 10:12:09 +1100 (EST)
Date: Thu, 23 Feb 2006 17:02:40 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>
Subject: parsing of some early cmdline options
Message-ID: <Pine.LNX.4.44.0602231658210.16092-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Guys,

I noticed that we have code in arch/powerpc/kernel/prom_init.c to handle 
parsing iommu=, mem=, and crashkernel=.

The problem I have is that we only use/build prom_init.c on MULTIPLATFORM 
(coming from true OF).

Any ideas on how to handle this for the !MULTIPLATFORM cases.  I'm most 
concerned about mem=.

- kumar

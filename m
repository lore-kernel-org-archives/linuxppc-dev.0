Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2D05CDDE2B
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Nov 2007 06:49:02 +1100 (EST)
Subject: Re: [RFC/PATCH 5/14] powerpc: Fix 440/440A machine check handling
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20071121071240.141d2917@weaponx>
References: <1195625777.579001.269266058699.qpush@grosgo>
	<20071121061714.0AB82DEAF1@ozlabs.org>
	<20071121071240.141d2917@weaponx>
Content-Type: text/plain
Date: Thu, 22 Nov 2007 06:48:50 +1100
Message-Id: <1195674530.6970.86.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Why didn't you just add a ppc_md.machine_check_exception to the
> effected boards?  Then you could have gotten rid of the ifdefs all
> together.

Hrm... it's per processor, not per board. I didn't feel like digging
which board uses which processor and go fixup all the ppc_md's

Ben.

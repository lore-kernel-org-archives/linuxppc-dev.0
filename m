Return-Path: <jochen@scram.de>
Received: from mail.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.scram.de", Issuer "scram e.V. CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id B0D29DDDEA
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Apr 2008 23:31:37 +1100 (EST)
Message-ID: <47F4CE11.1090607@scram.de>
Date: Thu, 03 Apr 2008 14:31:13 +0200
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: Laurent Pinchart <laurentp@cse-semaphore.com>
Subject: Re: [PATCH] [POWERPC] CPM1: implement GPIO LIB API
References: <47E92EC8.7010700@scram.de>
	<200804031319.12715.laurentp@cse-semaphore.com>
In-Reply-To: <200804031319.12715.laurentp@cse-semaphore.com>
Content-Type: text/plain; charset=ISO-8859-15
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Laurent,

> I haven't checked all CPM1-based parts, but for the MPC855 family this doesn't 
> look right. The MPC855 has two 32-bit ports, port B and port E. Registers for 
> port B are dir, par, odr and dat, and registers for port E are dir, par, sor, 
> odr and dat.

You probably mean MPC885. Thanks for catching this, the 32bit registers really
are a mess on CPM1 platforms.

> Are you working on a similar patch for the CPM2 ? CPM2 I/O ports are 32 bit 
> wide and their registers are layed out like for port E on the MPC855. It 
> should thus be possible to share code between CPM1 and CPM2.

Yes, some common port setup code could probably be moved to cpm.c.

Thanks,
Jochen

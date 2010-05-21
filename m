Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e38.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 33389B7D49
	for <linuxppc-dev@ozlabs.org>; Fri, 21 May 2010 20:23:23 +1000 (EST)
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e38.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o4LAGnnb014954
	for <linuxppc-dev@ozlabs.org>; Fri, 21 May 2010 04:16:49 -0600
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP
	id o4LAN51k066546
	for <linuxppc-dev@ozlabs.org>; Fri, 21 May 2010 04:23:09 -0600
Received: from d03av05.boulder.ibm.com (loopback [127.0.0.1])
	by d03av05.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o4LAN4BX009544
	for <linuxppc-dev@ozlabs.org>; Fri, 21 May 2010 04:23:04 -0600
Date: Fri, 21 May 2010 06:22:55 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [git pull] Please pull powerpc.git next branch
Message-ID: <20100521102255.GC24511@zod.rchland.ibm.com>
References: <1274433088.1931.63.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1274433088.1931.63.camel@pasglop>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, May 21, 2010 at 07:11:28PM +1000, Benjamin Herrenschmidt wrote:
>Hi Linus !
>
>Here's the powerpc batch for this merge window.
>
>Most of it is in arch/powerpc, a few powerpc specific drivers are hit
>too, including removing one that has been unused (and unselectable in
>Kconfig) for a long time (hdpuftrs), probably remains of a long dead
>platform.

You missed my updated pull request.  I still have some patches sitting in my
-next branch that should go in.

josh

Return-Path: <linas@austin.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2A91F67BE5
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Nov 2006 08:11:00 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e3.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id kARLAj5L006745
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Nov 2006 16:10:45 -0500
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kARLAFRK030988
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Nov 2006 16:10:21 -0500
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kARLAECu022478
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Nov 2006 16:10:15 -0500
Date: Mon, 27 Nov 2006 15:10:13 -0600
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH] Reorganise and then fixup the pseries cpu hotplug code
Message-ID: <20061127211013.GI10879@austin.ibm.com>
References: <20061123021132.B03F767C18@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20061123021132.B03F767C18@ozlabs.org>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: srinivasa@in.ibm.com, ego@in.ibm.com, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>,
	Anton Blanchard <anton@samba.org>, ntl@pobox.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Nov 23, 2006 at 01:11:30PM +1100, Michael Ellerman wrote:
> The pseries cpu hotplug code is currently spread between ./kernel/rtas.c,
> ./platforms/pseries/smp.c and ./platforms/pseries/setup.c. Some of it is
> not #ifdef CONFIG_HOTPLUG_CPU, but it should be.
> 
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>

Ack'ed by: Linas Vepstas <linas@austin.ibm.com>

> Linas, Srinivasa, can you test that this addresses the problems you
> were seeing. It should, but it'd be good if you could test it.

Actually, I was debugging Srinivasa's problem long-distance, which
was an internally-reported bugzilla bug that had landed in my lap.
I don't actually have a testable config. But, based on this chain
of mails, I am happy with the result!

--linas

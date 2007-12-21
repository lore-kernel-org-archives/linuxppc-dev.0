Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B6D34DDF71
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Dec 2007 03:51:30 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id lBLGnXtL029845
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Dec 2007 11:49:33 -0500
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	lBLGnWDt496646
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Dec 2007 11:49:33 -0500
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lBLGnWvY015400
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Dec 2007 11:49:32 -0500
Date: Fri, 21 Dec 2007 10:43:47 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Valentine Barshak <vbarshak@ru.mvista.com>
Subject: Re: [PATCH 2/4] PowerPC: update 440EP(x)/440GR(x) identical PVR
	issue workaround
Message-ID: <20071221104347.54cd2ad5@zod.rchland.ibm.com>
In-Reply-To: <20071221162402.GA1673@ru.mvista.com>
References: <20071221160723.GA1430@ru.mvista.com>
	<20071221162402.GA1673@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 21 Dec 2007 19:24:02 +0300
Valentine Barshak <vbarshak@ru.mvista.com> wrote:

> Commit 3ee133269861dc449ad5be761aa8570b1b05571f introduced
> a CPU "model" property and thus broke PowerPC 440EP(x)/440GR(x)
> identical PVR workaround. The patch updates it to use the new
> model property for CPU identification.

Good catch.  I'll have to look more closely to see if anything else
would be broken by changing the cpu node name from "PowerPC,xxxx@0" to
"cpu@0".

josh

Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 60ADDDDEC7
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Jan 2007 08:13:15 +1100 (EST)
Subject: Re: [PATCH 1/5] [POWERPC] cpm2: CPM2 interrupt controller fix
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Vitaly Bordug <vbordug@ru.mvista.com>
In-Reply-To: <20070122235533.6f9f8d09@localhost.localdomain>
References: <20070113004150.1224.58427.stgit@localhost.localdomain>
	<17844.35471.554647.189851@cargo.ozlabs.ibm.com>
	<20070122164316.79569af9@localhost.localdomain>
	<1169495737.1582.7.camel@localhost.localdomain>
	<20070122235533.6f9f8d09@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 23 Jan 2007 08:13:08 +1100
Message-Id: <1169500388.1582.14.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Compilation fails on locating various CPM-related defines, that used to be in ppc/io.h. So, not to mangle new io.h I've added 
> mpc8260.h to have them defined there. This is not that beautiful, but stuff that is claimed to be supported should work
> and at least not bail out the compiler :).
> 
> I have appropriate fix in the queue, that gets rid of global IMMAP pointer yet keeping ppc happy,
> but the patch is to significant to get into the current kernel.

What about an fsl_cpm.h instead if that CPM exists on more than just
8260 ? (If not, that's ok then)

Ben

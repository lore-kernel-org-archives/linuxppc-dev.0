Return-Path: <jdl@jdl.com>
Received: from jdl.com (colo.jdl.com [66.118.10.122])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8CC4A67BD3
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Sep 2006 00:18:49 +1000 (EST)
To: vgoyal@in.ibm.com
Subject: Re: [Fastboot] [PATCH] kexec: remove memory reserve patching for
	powerpc device tree
In-Reply-To: Your message of "Thu, 21 Sep 2006 09:55:34 EDT."
	<20060921135534.GA1542@in.ibm.com>
References: <20060921011031.4BFEA67BCE@ozlabs.org>
	<1158803944.7062.9.camel@localhost.localdomain>
	<20060921025122.GA8573@verge.net.au>
	<1158810033.7062.23.camel@localhost.localdomain>
	<20060921135534.GA1542@in.ibm.com>
Date: Thu, 21 Sep 2006 09:18:39 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1GQPNv-0003yi-H5@jdl.com>
Cc: linuxppc-dev@ozlabs.org, Horms <horms@verge.net.au>,
	Fastboot mailing list <fastboot@lists.osdl.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So, like, the other day Vivek Goyal mumbled:
> 
> Now with distros adopting kexce-tools, I am in for maintaining the backward
> compatibility as far as possible. Putting a note in the code is good that
> down the line, get rid of this code.

Perhaps scheduling it as an entry in 

    Documentation/feature-removal-schedule.txt

just so people (distros) can plan around it?

jdl

Return-Path: <linas@austin.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 27004DDEDB
	for <linuxppc-dev@ozlabs.org>; Thu, 17 May 2007 02:43:55 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l4GGhppF013927
	for <linuxppc-dev@ozlabs.org>; Wed, 16 May 2007 12:43:51 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l4GGhoSs199016
	for <linuxppc-dev@ozlabs.org>; Wed, 16 May 2007 10:43:50 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l4GGhoCd029468
	for <linuxppc-dev@ozlabs.org>; Wed, 16 May 2007 10:43:50 -0600
Date: Wed, 16 May 2007 11:43:41 -0500
To: Bob Picco <bob.picco@hp.com>, johnrose@us.ibm.com
Subject: Re: your mail
Message-ID: <20070516164341.GA7008@austin.ibm.com>
References: <20070516133046.GB25792@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070516133046.GB25792@localhost>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, May 16, 2007 at 09:30:46AM -0400, Bob Picco wrote:
> Subject: Re: 2.6.22-rc1-mm1 powerpc build breakage
> 
> /usr/src/linux-2.6.22-rc1-mm1/drivers/pci/hotplug/rpadlpar_sysfs.c:132: error: unknown field `subsys' specified in initializer
> /usr/src/linux-2.6.22-rc1-mm1/drivers/pci/hotplug/rpadlpar_sysfs.c:132: warning: initialization from incompatible pointer type
> make[4]: *** [drivers/pci/hotplug/rpadlpar_sysfs.o] Error 1
> make[3]: *** [drivers/pci/hotplug] Error 2
> make[2]: *** [drivers/pci] Error 2
> make[1]: *** [drivers] Error 2
> make: *** [_all] Error 2

John Rose is working to fix this "real soon now".

--linas

Return-Path: <sven.luther@wanadoo.fr>
Received: from smtp-msa-out01.orange.fr (unknown [193.252.23.120])
	by ozlabs.org (Postfix) with ESMTP id 45CB767B7C
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Oct 2006 18:55:56 +1000 (EST)
Date: Fri, 20 Oct 2006 10:52:07 +0200
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] enable RTAS /proc for PowerPC/CHRP platform
Message-ID: <20061020085207.GA21103@powerlinux.fr>
References: <20061019070318.GA24642@aepfle.de>
	<1161300942.10524.64.camel@localhost.localdomain>
	<20061020054434.GC3277@aepfle.de>
	<1161323797.10524.150.camel@localhost.localdomain>
	<20061020062431.GB14390@powerlinux.fr>
	<20061020064456.GA3946@aepfle.de>
	<20061020065849.GA17286@powerlinux.fr>
	<20061020072037.GA4355@aepfle.de>
	<20061020073745.GC17286@powerlinux.fr>
	<D22CDFD1-C5A7-422E-9052-FFB5480AE06F@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <D22CDFD1-C5A7-422E-9052-FFB5480AE06F@kernel.crashing.org>
From: Sven Luther <sven.luther@wanadoo.fr>
Cc: akpm@osdl.org, Olaf Hering <olaf@aepfle.de>, Sven Luther <sl@bplan-gmbh.de>,
	tilmann@bitterberg.de, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Oct 20, 2006 at 10:12:40AM +0200, Segher Boessenkool wrote:
> >>cpuinfo is about the cpu, not the board layout nor the firmware
> >>expectations.
> >
> >What is the machine: field doing there then ? Would it make sense  
> >to provide a
> >machineinfo then ?
> 
> Yes.  Or better, don't use /proc, get all info from sysfs
> (with a nice userland tool to summarize the info, perhaps).

Yeah, that makes sense. Will the device-tree move to /sys some day ? What
about things like the /rtas node ? 

But it will be years before all the distros move to it probably, see how most
of them still use parsing of the parted command line output for handling
partition table detection, and thus fail on anything not MBR.

Friendly,

Sven Luther

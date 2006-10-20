Return-Path: <sven.luther@wanadoo.fr>
Received: from smtp-msa-out01.orange.fr (unknown [193.252.23.120])
	by ozlabs.org (Postfix) with ESMTP id 37A0467C19
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Oct 2006 17:41:44 +1000 (EST)
Date: Fri, 20 Oct 2006 09:37:45 +0200
To: Olaf Hering <olaf@aepfle.de>
Subject: Re: [PATCH] enable RTAS /proc for PowerPC/CHRP platform
Message-ID: <20061020073745.GC17286@powerlinux.fr>
References: <20061018073851.GA13083@aepfle.de>
	<1161211083.10524.13.camel@localhost.localdomain>
	<20061019070318.GA24642@aepfle.de>
	<1161300942.10524.64.camel@localhost.localdomain>
	<20061020054434.GC3277@aepfle.de>
	<1161323797.10524.150.camel@localhost.localdomain>
	<20061020062431.GB14390@powerlinux.fr>
	<20061020064456.GA3946@aepfle.de>
	<20061020065849.GA17286@powerlinux.fr>
	<20061020072037.GA4355@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20061020072037.GA4355@aepfle.de>
From: Sven Luther <sven.luther@wanadoo.fr>
Cc: akpm@osdl.org, Sven Luther <sl@bplan-gmbh.de>, tilmann@bitterberg.de,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Oct 20, 2006 at 09:20:37AM +0200, Olaf Hering wrote:
> On Fri, Oct 20, Sven Luther wrote:
> 
> > Exact, it is not about poluting, but about rationalizing. The fact is that
> > these are the two infos that are the most necessary to userland, then why
> > disseminate the info in thousand different places, instead of making it easily
> > available in a canonical place in a standard format for everyone ? 
> 
> cpuinfo is about the cpu, not the board layout nor the firmware
> expectations.

What is the machine: field doing there then ? Would it make sense to provide a
machineinfo then ? 

Friendly,

Sven Luther

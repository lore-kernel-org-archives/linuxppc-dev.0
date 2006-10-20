Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17720.40586.748762.665487@cargo.ozlabs.ibm.com>
Date: Fri, 20 Oct 2006 20:01:46 +1000
From: Paul Mackerras <paulus@samba.org>
To: Olaf Hering <olaf@aepfle.de>
Subject: Re: [PATCH] enable RTAS /proc for PowerPC/CHRP platform
In-Reply-To: <20061020064456.GA3946@aepfle.de>
References: <20061017132243.GA6773@lst.de> <4535C0F8.1070905@bplan-gmbh.de>
	<1161152109.7906.6.camel@localhost.localdomain>
	<20061018073851.GA13083@aepfle.de>
	<1161211083.10524.13.camel@localhost.localdomain>
	<20061019070318.GA24642@aepfle.de>
	<1161300942.10524.64.camel@localhost.localdomain>
	<20061020054434.GC3277@aepfle.de>
	<1161323797.10524.150.camel@localhost.localdomain>
	<20061020062431.GB14390@powerlinux.fr>
	<20061020064456.GA3946@aepfle.de>
Cc: akpm@osdl.org, linuxppc-dev@ozlabs.org, Sven Luther <sl@bplan-gmbh.de>,
	tilmann@bitterberg.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Olaf Hering writes:

> About 32bit/64bit, maybe VmallocTotal from /proc/meminfo can be used.
> incredible large numer == must be a 64bit kernel
> No idea how reliable it is. There are those 36bit systems, but I bet
> they dont run a distro.

They only have 32-bit effective addresses and therefore a similar
VmallocTotal to any other 32-bit powerpc machine.

Paul.

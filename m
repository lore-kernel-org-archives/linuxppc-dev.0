Return-Path: <gerald.vanbaren@smiths-aerospace.com>
Received: from imagateway.smiths-aerospace.com (host241-chi.smiths-group.com
	[65.216.75.241]) by ozlabs.org (Postfix) with ESMTP id D70292BE83
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 15 Dec 2004 08:19:43 +1100 (EST)
Message-ID: <41BF5607.8040609@smiths-aerospace.com>
Date: Tue, 14 Dec 2004 16:07:19 -0500
From: Jerry Van Baren <gerald.vanbaren@smiths-aerospace.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
References: <62302.213.114.195.235.1103055907.squirrel@webmail1.unisite.se>
In-Reply-To: <62302.213.114.195.235.1103055907.squirrel@webmail1.unisite.se>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: Re: MEMORY PROBLEM
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

ppclinux@sundmangroup.com wrote:
> Hello,
> I have a Freescale-PPC8270 ( Former Motorola ) based board with 256Megs of
> RAM.
> 
> I am using the Montavista Vista Kernel 2.4.20.
> 
> When the system is handling larger files ~100M when NFS mounted and ~20M
> when RAMDISKed the kernel crashes since things are being overwritten in
> memory.
> 
> The crash happens when handling/creating large files by measn of e.g.
> * dd
> * gunzip
> * sftp download
> etc. it seems to be a general memory handling problem.
> 
> When looking at the memory though there are plenty of free space, or there
> should be plenty of free space but for some reason things are
> overwritten...
> 
> The Kernel reports actually 256M of memory. Top also shows that there is o
> r should be more than enough free memory for the operations I am trying to
> pull :-))
> 
> Can you give me suggestions where to start digging into this problem?
> 
> Best Regards // Matias

Your SDRAM initialization is suspect
   http://www.denx.de/twiki/bin/view/DULG/LinuxCrashesRandomly
   http://www.denx.de/twiki/bin/view/DULG/SDRAM
   http://www.denx.de/twiki/bin/view/DULG/UBootCrashAfterRelocation

gvb

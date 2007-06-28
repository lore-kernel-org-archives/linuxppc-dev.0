Return-Path: <tie-fei.zang@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 31619DDF78
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Jun 2007 16:55:24 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l5S6tJwS020874
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Jun 2007 23:55:19 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l5S6tH96013647
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Jun 2007 01:55:18 -0500 (CDT)
Subject: Re: for-2.6.23 branch in powerpc.git created
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <18034.6787.951861.623265@cargo.ozlabs.ibm.com>
References: <18034.6787.951861.623265@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Message-Id: <1183013700.17009.15.camel@localhost.localdomain>
Mime-Version: 1.0
Date: 28 Jun 2007 14:55:00 +0800
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2007-06-15 at 12:50, Paul Mackerras wrote:
> I have created a for-2.6.23 branch in the powerpc.git repository
> (git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git)
> where I have started queueing up patches to go in once the 2.6.23
> merge window opens.  For now at least it's the same as the master
> branch.
> 
> The patches I put in are listed below.  If you have a patch that
> should go in but isn't listed, remind me about it.
> 

Paul,
These patches should go in 2.6.23.
1 add cuboot for 7448hpc2 board
http://ozlabs.org/pipermail/linuxppc-dev/2007-May/036834.html

2. Remove redundant pci_read_irq_line() function for 85xx platform
Acked by Ben
http://ozlabs.org/pipermail/linuxppc-dev/2007-June/037117.html

3. Fix e500 v2 core reboot bug
http://ozlabs.org/pipermail/linuxppc-dev/2007-June/037799.html

4. Document the global utilities node define and example

http://ozlabs.org/pipermail/linuxppc-dev/2007-June/038136.html
http://ozlabs.org/pipermail/linuxppc-dev/2007-June/038137.html

Roy

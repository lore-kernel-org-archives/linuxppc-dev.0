Return-Path: <tie-fei.zang@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C5D0CDDEBB
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Jul 2007 18:26:15 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l638QAQ6016677
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Jul 2007 01:26:10 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l638Q2rF000440
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Jul 2007 03:26:03 -0500 (CDT)
Subject: Re: Patches added to 2.6.23 branch
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <18057.57417.999506.887803@cargo.ozlabs.ibm.com>
References: <18057.57417.999506.887803@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Message-Id: <1183451146.14800.4.camel@localhost.localdomain>
Mime-Version: 1.0
Date: 03 Jul 2007 16:25:46 +0800
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul

Could you help to add these patches:

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

On Tue, 2007-07-03 at 13:36, Paul Mackerras wrote: 
> The following patches have been added to the for-2.6.23 branch on
> powerpc.git.  In addition, the master branch has the merge of the
> for-2.6.23 and merge branches, which means that it is up-to-date with
> Linus' 2.6.22-rc7 plus the patches I recently asked Linus to pull for
> inclusion in 2.6.22.
> 
> Paul.

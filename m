Return-Path: <glppe-linuxppc-embedded-2@m.gmane.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 28D32DDE0E
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  8 Feb 2007 17:30:01 +1100 (EST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HF2mz-0005Uk-NR
	for linuxppc-embedded@ozlabs.org; Thu, 08 Feb 2007 07:29:50 +0100
Received: from dsl-202-45-109-210-static.VIC.netspace.net.au ([202.45.109.210])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Thu, 08 Feb 2007 07:29:49 +0100
Received: from daniel_ng11 by dsl-202-45-109-210-static.VIC.netspace.net.au
	with local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Thu, 08 Feb 2007 07:29:49 +0100
To: linuxppc-embedded@ozlabs.org
From: Daniel Ng <daniel_ng11@lycos.com>
Subject: multiple devices using ELDK NFS mounts
Date: Thu, 8 Feb 2007 06:29:44 +0000 (UTC)
Message-ID: <loom.20070208T072135-902@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: news <news@sea.gmane.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

I am working on multiple ELDK devices. So far, I just have one copy of the ELDK 
NFS mount per device. This gets unwieldly when we have more than a few devices, 
especially considering the size of one NFS mount being over 800Mb. 

Can you suggest a more efficient way? Something like sharing part of a single 
NFS mount across multiple devices? Or some other way?

Cheers,
Daniel

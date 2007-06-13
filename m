Return-Path: <biovore@biovore.net>
Received: from last-exile (unknown [207.114.88.194])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "biovore", Issuer "biovore" (not verified))
	by ozlabs.org (Postfix) with ESMTP id B4E16DDE0D
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Jun 2007 13:51:25 +1000 (EST)
Received: from kb3gtn.local (c-69-143-224-204.hsd1.md.comcast.net
	[69.143.224.204])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by last-exile (Postfix) with ESMTP id 5CBC645C200
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Jun 2007 23:26:00 -0400 (EDT)
From: biovore <biovore@biovore.net>
To: linuxppc-dev@ozlabs.org
Subject: ml-310 linux-2.6
Date: Tue, 12 Jun 2007 23:24:55 -0400
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200706122324.55394.biovore@biovore.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello,
	Dose anyone on this list know if a generic kernel from kernel.org can be 
built to run on the ml-310?  All I am trying to do first is just get a the 
serial port and the ddr memory controller working.. (no PCI)  I am using EDK 
9.1i on linux.   I have gotten the EDK to make the drivers and update the 
xparameters.h file but when I go to build it using my powerpc-405-linux-gnu- 
crosscompiler it fails and complains that there are allot of missing xilinix 
#defines.   

Any help would be nice.

Peter Fetterer
biovore(at)biovore.net

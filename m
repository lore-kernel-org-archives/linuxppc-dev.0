Return-Path: <willis@arlut.utexas.edu>
Received: from ns4.arlut.utexas.edu (ns4.arlut.utexas.edu [66.162.93.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 26AC4DDDCA
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 13 Oct 2007 05:23:20 +1000 (EST)
Received: from ns2.arlut.utexas.edu (ns2.arlut.utexas.edu [146.6.211.1])
	by ns4.arlut.utexas.edu (8.13.7/8.13.7) with ESMTP id l9CITo3c086916
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 12 Oct 2007 13:29:51 -0500 (CDT)
Received: from ns5.arlut.utexas.edu (ns5.arlut.utexas.edu [10.4.1.6])
	by ns2.arlut.utexas.edu (8.13.7/8.13.7) with ESMTP id l9CITjX6068765
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 12 Oct 2007 13:29:45 -0500 (CDT)
Subject: MPC85xx and linux IDE driver
From: Michael Brian Willis <willis@arlut.utexas.edu>
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain
Date: Fri, 12 Oct 2007 13:29:44 -0500
Message-Id: <1192213784.4862.48.camel@louie>
Mime-Version: 1.0
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello, 

I am using an MPC8540 based embedded system with a Compact Flash card in
true IDE mode. The Compact Flash card is directly connected to the
MPC8540 bus without the use of a pcmcia adapter. 

The Compact Flash card is being initialized correctly using the U-boot
boot-loader and is working properly as an ide device in U-boot. However
I cannot get linux to recognize the ide device.

I have tried several different linux config options and have tried
passing kernel command line options as advised in the
Documentation/ide.txt help file. However I have not been able to get the
kernel to recognize my ide device. 

Does anybody know if I can use the generic linux ide drivers? Or will I
need to modify/write my own driver for this type of setup? 

Any help is greatly appreciated. 


Regards, 

Michael Willis
Applied Research Labs - University of Texas
willis  <at>  arlut.utexas.edu

Return-Path: <willis@arlut.utexas.edu>
Received: from ns4.arlut.utexas.edu (ns4.arlut.utexas.edu [66.162.93.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 57D51DDE98
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  8 Aug 2007 04:47:46 +1000 (EST)
Received: from ns2.arlut.utexas.edu (ns2.arlut.utexas.edu [146.6.211.1])
	by ns4.arlut.utexas.edu (8.13.7/8.13.7) with ESMTP id l77HgrPg073288
	for <linuxppc-embedded@ozlabs.org>; Tue, 7 Aug 2007 12:42:53 -0500 (CDT)
Received: from ns5.arlut.utexas.edu (ns5.arlut.utexas.edu [10.4.1.6])
	by ns2.arlut.utexas.edu (8.13.7/8.13.7) with ESMTP id l77HghpS069238
	for <linuxppc-embedded@ozlabs.org>; Tue, 7 Aug 2007 12:42:44 -0500 (CDT)
Received: from louie (louie.arlut.utexas.edu [10.8.18.223])
	by ns5.arlut.utexas.edu (8.13.7/8.13.7) with ESMTP id l77Hghav044664
	for <linuxppc-embedded@ozlabs.org>; Tue, 7 Aug 2007 12:42:43 -0500 (CDT)
Subject: Fedora 7 on a non FPU system
From: Michael Brian Willis <willis@arlut.utexas.edu>
To: linuxppc-embedded@ozlabs.org
In-Reply-To: <20070314065411.GD14658@moe.telargo.com>
References: <20070313043050.GB82243@server.idefix.lan>
	<513703.69187.qm@web302.biz.mail.mud.yahoo.com>
	<20070314043305.GB27011@server.idefix.lan>
	<20070314065411.GD14658@moe.telargo.com>
Content-Type: text/plain
Date: Tue, 07 Aug 2007 12:42:41 -0500
Message-Id: <1186508561.5592.26.camel@louie>
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

I'm trying to install a Fedora 7 Root File System on an MPC8540 based
embedded system with a Denx 2.6.21 kernel. I have read the Denx
Application note located at: 
http://www.denx.de/wiki/DULG/AN2007_03_InstallFC7OnSequoia. 

However this App. Note says that the instructions apply only to
processors that have a full Floating Point Unit (FPU). My processor does
not have an FPU and I believe that this is causing some system hangs. 

Has anybody every successfully installed Fedora(or another major distro)
on a non-FPU system? Or, does anybody know what is needed to get it
working properly on a non FPU system? 

Any help is greatly appreciated. 

Regards,

Michael Willis
Applied Research Labs-University of Texas
willis@arlut.utexas.edu

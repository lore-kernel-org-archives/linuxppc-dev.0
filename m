Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F2A29DE0E1
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Oct 2008 08:05:46 +1100 (EST)
Subject: RE: Problems with PCI-E devices not being detected with switch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ayman El-Khashab <AymanE@tanisys.com>
In-Reply-To: <16691A8B34B5D9458EA3A1C37A11555A0137F829@tanisys-ex2.Tanisys.Local>
References: <16691A8B34B5D9458EA3A1C37A11555A0137F81E@tanisys-ex2.Tanisys.Local>
	<1224134422.8157.549.camel@pasglop>
	<16691A8B34B5D9458EA3A1C37A11555A0137F822@tanisys-ex2.Tanisys.Local>
	<1224202209.7654.36.camel@pasglop>
	<16691A8B34B5D9458EA3A1C37A11555A0137F829@tanisys-ex2.Tanisys.Local>
Content-Type: text/plain
Date: Sat, 18 Oct 2008 08:05:40 +1100
Message-Id: <1224277540.7654.97.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2008-10-17 at 09:54 -0500, Ayman El-Khashab wrote:
> Benjamin Herrenschmidt wrote:
> > On Thu, 2008-10-16 at 10:01 -0500, Ayman El-Khashab wrote:
> >> Benjamin Herrenschmidt wrote:
> >>> On Wed, 2008-10-15 at 10:47 -0500, Ayman El-Khashab wrote:
> >>> 
> >>> Note for people on CC: This is a problem on 460EX on a canyonland
> >>> using the 4x port. 
> >>> 
> > 
> > Ok, can you send me a full dmesg log with "debug" on the kernel
> > command line after adding a #define DEBUG 1 to the top of
> > drivers/pci/probe.c please ? (before the batch of #include).  
> > 
> 
> Yes, it is below.  I saw the #define DEBUG 1 turned on these messages
> below, but I am not sure how to verify that I correctly added the 
> "debug" to the kernel arguments.  (In u-boot I added them to the end
> of the ramargs variable)

It's ok. "debug" just makes those messages visible on the boot console,
'dmesg' always shows it all.

Ben.

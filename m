Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id 17FFB679F0
	for <linuxppc-dev@ozlabs.org>; Sat,  9 Dec 2006 01:04:32 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [patch 0/1] ipmi: add autosensing of ipmi device on powerpc using
	device-tree
Date: Fri, 8 Dec 2006 15:04:14 +0100
References: <20061207172259.64168f8c@localhost>
	<17784.46252.935.759285@cargo.ozlabs.ibm.com>
In-Reply-To: <17784.46252.935.759285@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200612081504.15471.arnd@arndb.de>
Cc: Christian Krafft <krafft@de.ibm.com>,
	openipmi-developer@lists.sourceforge.net, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 08 December 2006 01:41, Paul Mackerras wrote:
> Christian Krafft writes:
> 
> > the patch I'll send, adds of_device support to the ipmi_si module.
> > Having the correct device-tree entries, the ipmi module can be loaded without
> > specifying the resources as module parameters.
> 
> Which powerpc-based machines have IPMI?

This particular one is for an upcoming product, benh knows which one this
is for. The JS21 blade already has an IPMI controller, though that is
hidden behind the hypervisor, see 
http://www-03.ibm.com/systems/bladecenter/js21/specs.html.

	Arnd <><

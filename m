Return-Path: <moilanen@austin.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E7C15679F3
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Apr 2006 09:42:03 +1100 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e36.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k2VMg1jb020066
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Mar 2006 17:42:01 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k2VMclku222768
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Mar 2006 15:38:47 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id
	k2VMg0Rw028968
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Mar 2006 15:42:00 -0700
Date: Fri, 31 Mar 2006 16:35:04 -0600
From: Jake Moilanen <moilanen@austin.ibm.com>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 0/2] Base pSeries PCIe support
Message-Id: <20060331163504.a3b2f6fa.moilanen@austin.ibm.com>
In-Reply-To: <200604010028.43685.arnd@arndb.de>
References: <20060331160203.f2bf8b53.moilanen@austin.ibm.com>
	<200604010028.43685.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 1 Apr 2006 00:28:43 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

> Am Saturday 01 April 2006 00:02 schrieb Jake Moilanen:
> > Here are the two base patches for PCIe on pSeries for 2.6.17.
> >
> > This is enough to probe, find, configure, and run basic I/O to PCIe
> > enabled devices.
> 
> Does this use the draft PCIe bindings from Sun, or something else?
> Is it compatible with the way that Apple represents PCIe devices
> as plain PCI?
> 
> I'm just curious.

You can find some info on it:

	http://playground.sun.com/1275/bindings/pci/pci-express.txt

Jake

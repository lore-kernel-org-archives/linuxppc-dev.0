Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B8560DDDEB
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Feb 2007 01:45:07 +1100 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l1KEj43f018628
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Feb 2007 09:45:04 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by westrelay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id
	l1KEj4h9503802
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Feb 2007 07:45:04 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l1KEj4jD013900
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Feb 2007 07:45:04 -0700
Subject: Re: [0/14] Ebony support, 2nd spin
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200702201516.25160.arnd@arndb.de>
References: <20070220020837.GF17818@localhost.localdomain>
	<1171980307.24204.66.camel@zod.rchland.ibm.com>
	<200702201516.25160.arnd@arndb.de>
Content-Type: text/plain
Date: Tue, 20 Feb 2007 08:46:07 -0600
Message-Id: <1171982767.24204.70.camel@zod.rchland.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-02-20 at 15:16 +0100, Arnd Bergmann wrote:
> On Tuesday 20 February 2007 15:05, Josh Boyer wrote:
> > Which probably has something to do with the of_serial driver being used
> > now.  Just an FYI.
> 
> If you want to use of_serial together with serial console, you need
> to make sure that the detection logic in arch/powerpc/kernel/legacy_serial.c
> finds the port. It currently finds the serial port on axon, but that
> requires that the bus it's on is of type "opb" and the device itself
> is listed as "stdout" and has type "serial" and is compatible with
> "ns16750" (note: the others look for "ns16550" here).

The ebony dts has the ports as ns16550.  That is required for the
bootwrapper to find the port to use for it's output at the moment.

josh

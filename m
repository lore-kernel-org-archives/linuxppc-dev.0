Return-Path: <dwm@austin.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 15622DDF37
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Mar 2007 07:35:56 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l2LKaedK028264
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Mar 2007 16:36:40 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l2LKYnF9244024
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Mar 2007 16:34:49 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l2LKYnea014762
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Mar 2007 16:34:49 -0400
In-reply-to: <7a793472a33a30c35723be73e9cfce2f@kernel.crashing.org> 
References: <20070316172641.GA29709@ld0162-tx32.am.freescale.net>
	<20070316172853.GJ29784@ld0162-tx32.am.freescale.net>
	<20070317013159.GH3969@localhost.localdomain>
	<45FC8643.1080807@freescale.com>
	<20070318115656.GA12765@localhost.localdomain>
	<45FEA7B3.9090304@freescale.com>
	<1b943ac2c00b7f1f5696d006b67e9877@kernel.crashing.org>
	<46014BF5.6060509@freescale.com>
	<995355b28eecaafe955a5628ee939340@kernel.crashing.org>
	<46018315.1030703@freescale.com>
	<c4aa5f9e5e15d2e9686f77384f6cb532@kernel.crashing.org>
	<46018A00.9080703@freescale.com>
	<7a793472a33a30c35723be73e9cfce2f@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 10/17] bootwrapper: Add dt_set_mac_addresses(). 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 21 Mar 2007 15:34:42 -0500
Message-ID: <24462.1174509282@falcon10.austin.ibm.com>
From: Doug Maxey <dwm@austin.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Wed, 21 Mar 2007 20:48:25 BST, Segher Boessenkool wrote:
>Just everything everywhere that mentions "mac-address" should be
>completely and utterly eradicated :-)

FYI -
On a recent build of IBM ofw, on a 8844 booted from the ethernet@4,1

find /proc/device-tree/ -path \*ethernet@4,1\*
primero ~# find /proc/device-tree/ -path \*ethernet@4,*
/proc/device-tree/pci@8000000f8000000/pci@2/ethernet@4,1
/proc/device-tree/pci@8000000f8000000/pci@2/ethernet@4,1/name
/proc/device-tree/pci@8000000f8000000/pci@2/ethernet@4,1/linux,phandle
/proc/device-tree/pci@8000000f8000000/pci@2/ethernet@4,1/assigned-addresses
/proc/device-tree/pci@8000000f8000000/pci@2/ethernet@4,1/chosen-network-type
/proc/device-tree/pci@8000000f8000000/pci@2/ethernet@4,1/ibm,fw-driver-version
/proc/device-tree/pci@8000000f8000000/pci@2/ethernet@4,1/mac-address
/proc/device-tree/pci@8000000f8000000/pci@2/ethernet@4,1/local-mac-address
/proc/device-tree/pci@8000000f8000000/pci@2/ethernet@4,1/ibm,fw-device-code
/proc/device-tree/pci@8000000f8000000/pci@2/ethernet@4,1/address-bits
/proc/device-tree/pci@8000000f8000000/pci@2/ethernet@4,1/max-frame-size
/proc/device-tree/pci@8000000f8000000/pci@2/ethernet@4,1/ibm,fw-card-type
/proc/device-tree/pci@8000000f8000000/pci@2/ethernet@4,1/ibm,fw-adapter-name
/proc/device-tree/pci@8000000f8000000/pci@2/ethernet@4,1/supported-network-types
/proc/device-tree/pci@8000000f8000000/pci@2/ethernet@4,1/device_type
/proc/device-tree/pci@8000000f8000000/pci@2/ethernet@4,1/reg
/proc/device-tree/pci@8000000f8000000/pci@2/ethernet@4,1/compatible
/proc/device-tree/pci@8000000f8000000/pci@2/ethernet@4,1/built-in
/proc/device-tree/pci@8000000f8000000/pci@2/ethernet@4,1/133mhz-capable
/proc/device-tree/pci@8000000f8000000/pci@2/ethernet@4,1/66mhz-capable
/proc/device-tree/pci@8000000f8000000/pci@2/ethernet@4,1/fast-back-to-back
/proc/device-tree/pci@8000000f8000000/pci@2/ethernet@4,1/devsel-speed
/proc/device-tree/pci@8000000f8000000/pci@2/ethernet@4,1/subsystem-id
/proc/device-tree/pci@8000000f8000000/pci@2/ethernet@4,1/subsystem-vendor-id
/proc/device-tree/pci@8000000f8000000/pci@2/ethernet@4,1/max-latency
/proc/device-tree/pci@8000000f8000000/pci@2/ethernet@4,1/min-grant
/proc/device-tree/pci@8000000f8000000/pci@2/ethernet@4,1/interrupts
/proc/device-tree/pci@8000000f8000000/pci@2/ethernet@4,1/class-code
/proc/device-tree/pci@8000000f8000000/pci@2/ethernet@4,1/revision-id
/proc/device-tree/pci@8000000f8000000/pci@2/ethernet@4,1/device-id
/proc/device-tree/pci@8000000f8000000/pci@2/ethernet@4,1/vendor-id
/proc/device-tree/pci@8000000f8000000/pci@2/ethernet@4,1/ibm,loc-code
primero ~# 

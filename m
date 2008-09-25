Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6F0E1DDF47
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Sep 2008 01:09:15 +1000 (EST)
Received: from [IPv6:::1] (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id m8PF9ATw030864
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Sep 2008 10:09:10 -0500
Message-Id: <3A64D657-C24A-4672-8513-57EE9F37BCDA@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: docs for various "linux," properties in the device tree?
Date: Thu, 25 Sep 2008 10:09:10 -0500
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In search our code base we have the following set of properties:

"linux,boot-cpu"
"linux,boot-display"
"linux,bootx-addr"
"linux,bootx-depth"
"linux,bootx-height"
"linux,bootx-linebytes"
"linux,bootx-width"
"linux,crashkernel-base"
"linux,crashkernel-size"
"linux,drconf-usable-memory"
"linux,htab-base"
"linux,htab-size"
"linux,initrd-end"
"linux,initrd-start"
"linux,iommu-force-on"
"linux,iommu-off"
"linux,kernel-end"
"linux,memory-limit"
"linux,opened"
"linux,pci-assign-all-buses"
"linux,pci-probe-only"
"linux,phandle"
"linux,rtas-base"
"linux,rtas-entry"
"linux,stdout-package"
"linux,stdout-path"
"linux,tce-alloc-end"
"linux,tce-alloc-start"
"linux,tce-base"
"linux,tce-size"
"linux,unit_address"
"linux,usable-memory"

Some of these are spec'd in booting-with-of.  what about the others?

- k

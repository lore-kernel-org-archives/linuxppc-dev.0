Return-Path: <glppe-linuxppc-embedded-2@m.gmane.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by ozlabs.org (Postfix) with ESMTP id C6A94B6F7F
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Jun 2011 00:33:59 +1000 (EST)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glppe-linuxppc-embedded-2@m.gmane.org>)
	id 1QZ1n2-0003rz-CC
	for linuxppc-dev@ozlabs.org; Tue, 21 Jun 2011 16:18:52 +0200
Received: from 91.213.169.4 ([91.213.169.4])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Jun 2011 16:18:52 +0200
Received: from dbaryshkov by 91.213.169.4 with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Jun 2011 16:18:52 +0200
To: linuxppc-dev@ozlabs.org
From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Subject: Re: [PATCH 0/15] Hypervisor-mode KVM on POWER7 and PPC970
Date: Tue, 21 Jun 2011 14:18:39 +0000 (UTC)
Message-ID: <itq97v$dc$1@dough.gmane.org>
References: <20110618082705.GA28413__14973.6630417921$1308385948$gmane$org@bloggs.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Paul Mackerras wrote:

> The following series of patches enable KVM to exploit the hardware
> hypervisor mode on 64-bit Power ISA Book3S machines.  At present,
> POWER7 and PPC970 processors are supported.  (Note that the PPC970
> processors in Apple G5 machines don't have a usable hypervisor mode
> and are not supported by these patches.)

I have a Maple board (dual PPC970FX). Will this patchset work on it?
Should I add any additional changes to add support for this platform?

Thanks!

-- 
With best wishes
Dmitry

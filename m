Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A8F79DDF2A
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Apr 2008 22:03:19 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m31B3Ev9028578
	for <linuxppc-dev@ozlabs.org>; Tue, 1 Apr 2008 07:03:14 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m31B3EP8183966
	for <linuxppc-dev@ozlabs.org>; Tue, 1 Apr 2008 07:03:14 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m31B3E8A015871
	for <linuxppc-dev@ozlabs.org>; Tue, 1 Apr 2008 07:03:14 -0400
Date: Tue, 1 Apr 2008 06:03:03 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] Add idle power save for ppc 4xx
Message-ID: <20080401060303.24641139@zod.rchland.ibm.com>
In-Reply-To: <18417.45926.65587.820132@cargo.ozlabs.ibm.com>
References: <10aea37177130bbe5de7.1206969157@thinkpadL>
	<1206983237.12155.60.camel@vader.jdub.homelinux.org>
	<20080331130518.2a6b0264@zod.rchland.ibm.com>
	<18417.45926.65587.820132@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: kvm-ppc-devel@lists.sourceforge.net, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 1 Apr 2008 15:00:38 +1100
Paul Mackerras <paulus@samba.org> wrote:

> Josh Boyer writes:
> 
> > Actually, you probably don't want this as a property in the device
> > tree.  It doesn't describe hardware.  A Kconfig option might be
> > warranted though.
> 
> In general it is valid to have properties in the device tree that
> describe the hypervisor or the kernel's interface to it, since they
> are aspects of the platform, i.e. the virtual "hardware" that the
> kernel is running on.

Yep, we reached that conclusion already.

josh

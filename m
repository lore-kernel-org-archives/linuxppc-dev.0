Return-Path: <mohan@in.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C9AB6DE239
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Oct 2008 03:34:47 +1100 (EST)
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
	by e5.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m99GYhnk022090
	for <linuxppc-dev@ozlabs.org>; Thu, 9 Oct 2008 12:34:43 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	m99GYSRO1892352
	for <linuxppc-dev@ozlabs.org>; Thu, 9 Oct 2008 12:34:29 -0400
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m99GYP9d014773
	for <linuxppc-dev@ozlabs.org>; Thu, 9 Oct 2008 10:34:25 -0600
Message-ID: <48EE3288.7080105@in.ibm.com>
Date: Thu, 09 Oct 2008 22:04:16 +0530
From: Mohan Kumar M <mohan@in.ibm.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] Fix kdump kernel hang issue with relocatable kernel
	patches
References: <20081001182501.GA20319@in.ibm.com>
	<18669.38794.476429.103254@cargo.ozlabs.ibm.com>
In-Reply-To: <18669.38794.476429.103254@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: ppcdev <linuxppc-dev@ozlabs.org>, kexec@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul Mackerras wrote:

> 
> Hmmm.  Is there any reason to continue to support non-relocatable
> 64-bit kernels being kdump kernels?  In other words, for 64-bit,
> couldn't we make CONFIG_CRASH_DUMP depend on CONFIG_RELOCATABLE?

We wanted to support legacy kdump feature on 64 bit kernels for some 
time. But if nobody needs the legacy kdump, we can make kdump depend on 
relocatable

Regards,
Mohan.

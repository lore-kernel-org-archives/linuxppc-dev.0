Return-Path: <benh@kernel.crashing.org>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp07.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B6AD9B6F12
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Apr 2011 16:14:18 +1000 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.31.245])
	by e23smtp07.au.ibm.com (8.14.4/8.13.1) with ESMTP id p356EHbc018890
	for <linuxppc-dev@ozlabs.org>; Tue, 5 Apr 2011 16:14:17 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p356EHBp1523938
	for <linuxppc-dev@ozlabs.org>; Tue, 5 Apr 2011 16:14:17 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p356EHp3024331
	for <linuxppc-dev@ozlabs.org>; Tue, 5 Apr 2011 16:14:17 +1000
Received: from ozlabs.au.ibm.com (ozlabs.au.ibm.com [9.190.163.12])
	by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
	p356EHIs024328
	for <linuxppc-dev@ozlabs.org>; Tue, 5 Apr 2011 16:14:17 +1000
Received: from grosgo.ozlabs.ibm.com (haven.au.ibm.com [9.190.164.82])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 5994B73A42
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Apr 2011 16:14:17 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCHES] Bits and pieces for Power7 support in HV mode
Date: Tue,  5 Apr 2011 16:13:56 +1000
Message-Id: <1301984051-18413-1-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Here's a patch series which adds bits and pieces (and in some case
not directly related cleanups that will be useful for the upcoming
platform that uses that stuff) to allow running a recent CPU in
hypervisor mode.

It applies on top of the few cleanups and the XICS rewrite I've
already posted and is a pre-requisite for the upcoming KVM support
and the "non-virtualized" platform (still brewing).

I've also put them in my "test" branch

Cheers,
Ben.

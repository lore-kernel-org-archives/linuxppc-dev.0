Return-Path: <benh@kernel.crashing.org>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp05.au.ibm.com",
	Issuer "GeoTrust SSL CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 507CFB6EF7
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Mar 2011 17:37:40 +1100 (EST)
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [202.81.31.247])
	by e23smtp05.au.ibm.com (8.14.4/8.13.1) with ESMTP id p286W3es001533
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Mar 2011 17:32:03 +1100
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p286bd3b1331386
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Mar 2011 17:37:39 +1100
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p286bcWh008949
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Mar 2011 17:37:38 +1100
Received: from ozlabs.au.ibm.com (ozlabs.au.ibm.com [9.190.163.12])
	by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
	p286bcM7008933
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Mar 2011 17:37:38 +1100
Received: from grosgo.ozlabs.ibm.com (haven.au.ibm.com [9.190.164.82])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 1291C7347E
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Mar 2011 17:37:38 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCHES] powerpc: Cleanup and fix CPU hotplug
Date: Tue,  8 Mar 2011 17:37:12 +1100
Message-Id: <1299566250-10516-1-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This series contain a number of cleanups and fixes to our CPU hotplug
code, including fixing crashes on G5 machines, properly re-initializing
idle threads etc...

Tested on PowerMac G5 and pSeries machines.

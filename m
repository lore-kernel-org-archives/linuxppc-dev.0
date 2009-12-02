Return-Path: <arun@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp01.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 21F65B7BDD
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  2 Dec 2009 20:54:34 +1100 (EST)
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [202.81.31.247])
	by e23smtp01.au.ibm.com (8.14.3/8.13.1) with ESMTP id nB29qs6U018230
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Dec 2009 20:52:54 +1100
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nB29or1k1294424
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Dec 2009 20:50:53 +1100
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	nB29sWbi008703
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Dec 2009 20:54:33 +1100
Date: Wed, 2 Dec 2009 15:24:27 +0530
From: Arun R Bharadwaj <arun@linux.vnet.ibm.com>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Ingo Molnar <mingo@elte.hu>,
	Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
	Dipankar Sarma <dipankar@in.ibm.com>, Balbir Singh <balbir@in.ibm.com>,
	Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
	Arun Bharadwaj <arun@linux.vnet.ibm.com>
Subject: [v10 PATCH 0/9] cpuidle: cleanup cpuidle/ introduce cpuidle to POWER
Message-ID: <20091202095427.GA27251@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: linux-arch@vger.kernel.org, linux-acpi@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Reply-To: arun@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

This patchset introduces cpuidle infrastructure to POWER, prototyping
for pSeries, and also does a major refactoring of current x86 idle
power management and a cleanup of cpuidle infrastructure.

This patch series has been in discussion for quite a while now and
below are the links to the previous discussions.

Please consider this for inclusion into the -tip tree.

v9 --> http://lkml.org/lkml/2009/10/16/63
v8 --> http://lkml.org/lkml/2009/10/8/82
v7 --> http://lkml.org/lkml/2009/10/6/278
v6 --> http://lkml.org/lkml/2009/9/22/180
v5 --> http://lkml.org/lkml/2009/9/22/26
v4 --> http://lkml.org/lkml/2009/9/1/133
v3 --> http://lkml.org/lkml/2009/8/27/124
v2 --> http://lkml.org/lkml/2009/8/26/233
v1 --> http://lkml.org/lkml/2009/8/19/150


Change in this version:

        Pavel noticed that the code which calls the cpuidle's idle
        loop was repeated at many places. So this set optimizes it so
        that we dont have repetition of code. The rest of the patches
        are same as the earlier iteration.


arun

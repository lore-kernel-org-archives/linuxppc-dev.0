Return-Path: <pbadari@us.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5EA96DDE02
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Feb 2008 03:40:43 +1100 (EST)
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m1SGeeD9004283
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Feb 2008 11:40:40 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m1SGeXqA028520
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Feb 2008 09:40:35 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m1SGeX0n027207
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Feb 2008 09:40:33 -0700
Received: from dyn9047017100.beaverton.ibm.com
	(dyn9047017100.beaverton.ibm.com [9.47.17.100])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	m1SGeXbJ027175
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Feb 2008 09:40:33 -0700
Subject: [PATCH 0/3] hotplug memory remove updates
From: Badari Pulavarty <pbadari@us.ibm.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain
Date: Thu, 28 Feb 2008 08:43:47 -0800
Message-Id: <1204217028.28696.10.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Paul,

Here are the hotplug memory remove updates for 2.6.25-rc2-mm1.

[PATCH 1/3] ppc64-specific remove htab bolted mapping support
[PATCH 2/3] generic __remove_pages() support
[PATCH 3/3] ppc64-specific memory notifier support

As you can see PATCH 1,3 are ppc64-specific. PATCH 1 was already
reviewed by you. Could you please review PATCH 3 and let me know,
if I missing something ?

I would like to submit these for -mm inclusion after your review.

Thanks,
Badari

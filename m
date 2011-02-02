Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e37.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 10FAFB710F
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  3 Feb 2011 01:32:39 +1100 (EST)
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e37.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id p12EU3YL028979
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Feb 2011 07:30:03 -0700
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p12EWXHf111304
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Feb 2011 07:32:33 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p12EWXQK027199
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Feb 2011 07:32:33 -0700
Received: from zod.rchland.ibm.com ([9.12.228.69])
	by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
	p12EWWKX027089
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Feb 2011 07:32:32 -0700
Date: Wed, 2 Feb 2011 09:31:55 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: 4xx next branch
Message-ID: <20110202143155.GB17643@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi All,

I've added the following patches to my next branch:

Dave Kleikamp (2):
      powerpc/476: define specific cpu table entry DD2 core
      powerpc/476: Workaround for PLB6 hang

Rupjyoti Sarmah (1):
      powerpc/44x: PHY fixup for USB on canyonlands board

Tirumala Marri (1):
      powerpc/44x: Add USB DWC DTS entry to Canyonlands board


There are a few more I'd like to review still, including the AMP support
for 476 before I ask Ben to pull.  The above patches will sit in my
branch for a few days.  If there are any others I have missed, please
let me know.

josh

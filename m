Return-Path: <dave@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 484D8474C1
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Dec 2008 05:40:25 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e34.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id mBBIdVRq011388
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Dec 2008 11:39:31 -0700
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	mBBIe7Oh112886
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Dec 2008 11:40:13 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	mBBIe56v004167
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Dec 2008 11:40:07 -0700
Subject: Re: [PATCH 0/2] Fix a bug and cleanup NUMA boot-time code
From: Dave Hansen <dave@linux.vnet.ibm.com>
To: paulus@samba.org
In-Reply-To: <20081211183603.981E651D@kernel>
References: <20081211183603.981E651D@kernel>
Content-Type: text/plain
Date: Thu, 11 Dec 2008 10:40:01 -0800
Message-Id: <1229020801.17206.35.camel@nimitz>
Mime-Version: 1.0
Cc: Jon Tollefson <kniht@linux.vnet.ibm.com>, Mel Gorman <mel@csn.ul.ie>,
	linuxppc-dev@ozlabs.org, "Serge E. Hallyn" <serue@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Gah, sorry.  I resent my description for the whole series from yesterday
instead of one just for these bug fixes.

The first patch removes a warning in numa.c that I just caused.

The second one is a rework of the bug fix that was at the head of the
series yesterday, addressing some comments that Paul made.

-- Dave

Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 60A3BDDFA9
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Dec 2007 07:35:04 +1100 (EST)
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id lB6KZ049004509
	for <linuxppc-dev@ozlabs.org>; Thu, 6 Dec 2007 15:35:00 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	lB6KYwSW117980
	for <linuxppc-dev@ozlabs.org>; Thu, 6 Dec 2007 13:34:59 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lB6KYtWt001552
	for <linuxppc-dev@ozlabs.org>; Thu, 6 Dec 2007 13:34:55 -0700
Received: from zod.rchland.ibm.com (wecm-9-67-146-77.wecm.ibm.com
	[9.67.146.77])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	lB6KYsXf001471
	for <linuxppc-dev@ozlabs.org>; Thu, 6 Dec 2007 13:34:54 -0700
Date: Thu, 6 Dec 2007 14:32:02 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: 2.6.25-candidates branch updated in 4xx tree
Message-ID: <20071206143202.331082b3@zod.rchland.ibm.com>
In-Reply-To: <20071204131139.3c6be92f@zod.rchland.ibm.com>
References: <20071204131139.3c6be92f@zod.rchland.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 4 Dec 2007 13:11:39 -0600
Josh Boyer <jwboyer@linux.vnet.ibm.com> wrote:

> For those following my tree, I've added a 2.6.25-candidates branch and
> based it off of Paul's latest master.  (If you've already pulled
> you'll have to reset, sorry.)

I've updated this again with BenH's latest PCI patch series.  There are
a couple more commits from Stefan and Valentine for various platform
fixes, and I've also fixed the 4xx DTS files to work with both the old
and new DTC versions.

josh

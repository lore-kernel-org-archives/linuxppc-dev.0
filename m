Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 338FDB6F92
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 25 May 2011 20:42:10 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e34.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id p4PATPOR017505
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 May 2011 04:29:25 -0600
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP
	id p4PAhMKF145788
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 May 2011 04:43:22 -0600
Received: from d03av05.boulder.ibm.com (loopback [127.0.0.1])
	by d03av05.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p4PAfwCf012625
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 May 2011 04:41:59 -0600
Date: Wed, 25 May 2011 06:43:11 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Michael Neuling <mikey@neuling.org>
Subject: Re: Best Linux choice for POWER7?
Message-ID: <20110525104311.GB22207@zod.rchland.ibm.com>
References: <BANLkTinLMava9Oyke2OL7Xy==h8AhBywfQ@mail.gmail.com>
	<452.1306288195@neuling.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <452.1306288195@neuling.org>
Cc: Gabriel Menini <gabriel.menini@gmail.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 25, 2011 at 11:49:55AM +1000, Michael Neuling wrote:
>Gabriel,
>
>> I am looking for the most-tested Linux distro for POWER7 architecture.
>
>IBM partnered with RedHat and Novell to make sure RHEL6 and SLES11 SP1 are
>well tested with POWER7.  Essential back-ports and bug are included in
                                                   ^  bug _fixes_

We try really hard to not add essential bugs ;).

josh

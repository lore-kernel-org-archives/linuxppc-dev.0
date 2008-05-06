Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7D20CDDE24
	for <linuxppc-dev@ozlabs.org>; Wed,  7 May 2008 07:50:38 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m46LldYl023479
	for <linuxppc-dev@ozlabs.org>; Tue, 6 May 2008 17:47:39 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m46LoYvA051816
	for <linuxppc-dev@ozlabs.org>; Tue, 6 May 2008 15:50:34 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m46LoY9o017054
	for <linuxppc-dev@ozlabs.org>; Tue, 6 May 2008 15:50:34 -0600
Date: Tue, 6 May 2008 16:49:15 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: arch/ppc is broken
Message-ID: <20080506164915.3f15cfe8@zod.rchland.ibm.com>
In-Reply-To: <e568c51ffa5f865094b26827ef959aa1@kernel.crashing.org>
References: <20080506150955.0fdcaa85@zod.rchland.ibm.com>
	<e568c51ffa5f865094b26827ef959aa1@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 6 May 2008 23:39:34 +0200
Segher Boessenkool <segher@kernel.crashing.org> wrote:

> > Every arch/ppc defconfig I built today failed.  Someone broke it.
> 
> On a related note, arch/ppc defconfig doesn't even configure anymore;
> common_defconfig was removed, but it is still the default.  What config
> should we use as default now?

I'd be willing to guess that the answer is "nothing".  You're welcome
to use ebony_defconfig but that's just as much unmaintained as the rest
of arch/ppc and only builds when someone doesn't break it.

> Josh, I'll look into the build failure now.

Masochist ;)

josh

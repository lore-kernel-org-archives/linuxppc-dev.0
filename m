Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e39.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B6B8AB6EEC
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Jul 2010 04:22:24 +1000 (EST)
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
	[9.17.195.226])
	by e39.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id o68ICsIs015513
	for <linuxppc-dev@ozlabs.org>; Thu, 8 Jul 2010 12:12:54 -0600
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
	by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP
	id o68IMDnM059692
	for <linuxppc-dev@ozlabs.org>; Thu, 8 Jul 2010 12:22:14 -0600
Received: from d03av05.boulder.ibm.com (loopback [127.0.0.1])
	by d03av05.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id o68IMC5s003725
	for <linuxppc-dev@ozlabs.org>; Thu, 8 Jul 2010 12:22:12 -0600
Date: Thu, 8 Jul 2010 14:22:10 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Lee Nipper <lee.nipper@gmail.com>
Subject: Re: 405EX Rev D mis-identification?
Message-ID: <20100708182210.GB28969@zod.rchland.ibm.com>
References: <AANLkTikrUvEicL1DaeLz9Vr-lE_hkKZqJi_7qzERZMu8@mail.gmail.com>
	<AANLkTikCFgFZsAl0QLkZbI1Jbrh8v0d7gK9EVtqCe1QU@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AANLkTikCFgFZsAl0QLkZbI1Jbrh8v0d7gK9EVtqCe1QU@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jul 08, 2010 at 12:59:29PM -0500, Lee Nipper wrote:
>On Thu, Jul 8, 2010 at 10:06, Marc Chidester <marcchidester@gmail.com> wrote:
>> It looks like the Rev D version of the 405EX chip without security
>> will be identified as a 405EXr, based on the values in the cpu_specs
>> table.
>
>Yes, that is the case.
>The 405EX Rev D without security PVR matches an old 405EXr A/B with security,
>and hence the cpu_spec entries' pvr_mask values are no longer correct.
>
>> Is there an algorithm update needed or am I missing something?
>
>Perhaps add more cpu_spec table entries for the 405EX & 405EXr with
>pvr_mask = 0xffff000f  ?

Have you tried that in a locally modified kernel?  If so, did it work?  If so,
care to submit a patch? :)

josh

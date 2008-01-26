Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D4139DDE36
	for <linuxppc-dev@ozlabs.org>; Sun, 27 Jan 2008 04:30:08 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m0QHU5LB012102
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Jan 2008 12:30:05 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m0QHU4xc089760
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Jan 2008 10:30:04 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m0QHU4R6008270
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Jan 2008 10:30:04 -0700
Date: Sat, 26 Jan 2008 11:29:34 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: Patches added to for-2.6.25/master branches of powerpc.git
Message-ID: <20080126112934.54815ecb@zod.rchland.ibm.com>
In-Reply-To: <18330.53318.857148.409675@cargo.ozlabs.ibm.com>
References: <18330.53318.857148.409675@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 26 Jan 2008 17:16:38 +1100
Paul Mackerras <paulus@samba.org> wrote:

> This includes commits pulled from Josh Boyer, Kumar Gala, Grant
> Likely, and Olof Johansson.  I reverted the "Fake NUMA emulation for
> PowerPC" commit because it changed behaviour even when the fake numa
> command-line option wasn't given.
> 
> I'll be asking Linus to pull within the next few days, so please
> remind me about anything else that should go in 2.6.25.

I have a couple patches that depend on the netdev and USB
trees being merged first.  And I'm sure we'll have some bug fix patches
at some point to deal with the clash-o-git trees that seems to be
coming.

josh

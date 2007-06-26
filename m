Return-Path: <stevewin@us.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id CA6C7DDEEA
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 27 Jun 2007 07:37:15 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e32.co.us.ibm.com (8.12.11.20060308/8.13.8) with ESMTP id
	l5QLWBDO003211
	for <linuxppc-embedded@ozlabs.org>; Tue, 26 Jun 2007 17:32:11 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l5QLbAUH259222
	for <linuxppc-embedded@ozlabs.org>; Tue, 26 Jun 2007 15:37:10 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l5QLbAsS010300
	for <linuxppc-embedded@ozlabs.org>; Tue, 26 Jun 2007 15:37:10 -0600
In-Reply-To: <1182877959.19501.17.camel@weaponx.rchland.ibm.com>
To: jwboyer@linux.vnet.ibm.com, vbarshak@ru.mvista.com
MIME-Version: 1.0
Subject: Re: Katmai w/ DENX git - "init has generated signal 4" error
Message-ID: <OF374AD003.85F388B3-ON87257306.0075D915-85257306.0076BA68@us.ibm.com>
From: Stephen Winiecki <stevewin@us.ibm.com>
Date: Tue, 26 Jun 2007 17:38:31 -0400
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Josh Boyer <jwboyer@linux.vnet.ibm.com> wrote on 06/26/2007 01:12:38 PM:

> Signal 4 is SIGILL, which could be returned for float instructions I
> suppose.  Try turning on CONFIG_MATH_EMULATION in your kernel config for
> Katmai and see if the problem goes away.

Thanks Josh - that actually did the trick w/ the original distro (which 
apparently generates some FP ops).

Valentine Barshak <vbarshak@ru.mvista.com> wrote on 06/26/2007 01:58:23 
PM:
> Looks like 440SPe entry  is missing in the arch/ppc/kernel/cputable.c

I'm using a git snapshot version of the DENX kernel - is there some effort 
underway to start to merge this platform support into the public tree?

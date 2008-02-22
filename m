Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7EF03DDF88
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 23 Feb 2008 09:36:31 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m1MMcOmT025501
	for <linuxppc-embedded@ozlabs.org>; Fri, 22 Feb 2008 17:38:24 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m1MMaRHo226550
	for <linuxppc-embedded@ozlabs.org>; Fri, 22 Feb 2008 17:36:27 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m1MMaRKh000919
	for <linuxppc-embedded@ozlabs.org>; Fri, 22 Feb 2008 17:36:27 -0500
Date: Fri, 22 Feb 2008 16:36:25 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Steve Heflin <sheflin@newagemicro.com>
Subject: Re: MODPOST section mismatches
Message-ID: <20080222163625.29433d12@weaponx>
In-Reply-To: <20080222222637.C82EADDF0F@ozlabs.org>
References: <20080221213313.97814DDF55@ozlabs.org>
	<20080222164210.48628DE0A9@ozlabs.org>
	<20080222145224.7349cf36@weaponx>
	<20080222222637.C82EADDF0F@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Fri, 22 Feb 2008 17:26:52 -0500
Steve Heflin <sheflin@newagemicro.com> wrote:

> FLAT_MEM is one of the configuration options:
>        CONFIG_ARCH_FLATMEM_ENABLE=y

That has to do with NUMA stuff.  It really doesn't have much bearing on
the section warnings.

josh

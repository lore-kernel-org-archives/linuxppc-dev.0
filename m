Return-Path: <rdreier@cisco.com>
Received: from sj-iport-6.cisco.com (sj-iport-6.cisco.com [171.71.176.117])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "sj-iport-6.cisco.com", Issuer "Cisco SSCA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 733BFDEC04
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Aug 2008 02:33:17 +1000 (EST)
From: Roland Dreier <rdreier@cisco.com>
To: jwboyer@linux.vnet.ibm.com
Subject: Re: [PATCH 1/9] powerpc/44x: Add PowerPC 44x simple platform support
References: <cover.1219160188.git.jwboyer@linux.vnet.ibm.com>
	<496103659f7b122a8301703b055ef4c6bd3092af.1219160188.git.jwboyer@linux.vnet.ibm.com>
	<200808201533.22258.arnd@arndb.de>
	<fa686aa40808200715x6c850593p5655d8b5b8e7b61e@mail.gmail.com>
	<1219243548.26429.25.camel@jdub.homelinux.org>
Date: Wed, 20 Aug 2008 09:33:06 -0700
In-Reply-To: <1219243548.26429.25.camel@jdub.homelinux.org> (Josh Boyer's
	message of "Wed, 20 Aug 2008 10:45:47 -0400")
Message-ID: <adak5ebpry5.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 > You should fix 52xx with the same for loop change then, since I
 > blatantly most of this file from you ;)

Heh, then factor out mpc5200_simple_probe() into a helper and use it
instead of copying it as ppc44x_probe?  ;)

If you stick to the NULL-terminated array version, then it becomes easy
to convert some other platform probing code to use your new code too, eg
tqm85xx_probe() could use an array too.

 - R.

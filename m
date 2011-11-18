Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 9ED2AB725F
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Nov 2011 01:35:12 +1100 (EST)
Subject: Re: [PATCH v2 1/7] powerpc/85xx: re-enable timebase sync disabled by
 KEXEC patch
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <4EC40406.1030408@freescale.com>
Date: Fri, 18 Nov 2011 08:35:02 -0600
Message-Id: <54122A43-37D1-438B-A0DD-289B7AE2BA0B@kernel.crashing.org>
References: <1321437344-19253-1-git-send-email-chenhui.zhao@freescale.com>
 <4EC40406.1030408@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org, Zhao Chenhui <chenhui.zhao@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Nov 16, 2011, at 12:42 PM, Scott Wood wrote:

> On 11/16/2011 03:55 AM, Zhao Chenhui wrote:
>> From: Li Yang <leoli@freescale.com>
>>=20
>> The timebase sync is not only necessary when using KEXEC. It should =
also
>> be used by normal boot up and cpu hotplug. Remove the ifdef added by
>> the KEXEC patch.
>=20
> Again, no it should not be used by normal boot up (whether KEXEC =
support
> is enabled or not).  We should only do timebase sync when we actually
> need to (when we've actually just reset a core), and we should do it =
the
> way U-Boot does rather than with smp-tbsync.c.


How can we do u-boot bases timebase sync after the system us up and =
running?  For example would we losing some ticks of time in the case =
that one core is up and we bring a second core online?

- k=

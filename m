Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
 by ozlabs.org (Postfix) with SMTP id 0E14A2C0092
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Mar 2013 20:42:11 +1100 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 31546-10 for <linuxppc-dev@lists.ozlabs.org>;
 Wed, 13 Mar 2013 09:42:02 +0000 (GMT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Subject: RE: [PATCH V4] powerpc/85xx: Add machine check handler to fix PCIe
 erratum on mpc85xx
Date: Wed, 13 Mar 2013 09:40:40 -0000
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6026B7186@saturn3.aculab.com>
In-Reply-To: <1363123452.17135.13@snotra>
References: <412C8208B4A0464FA894C5F0C278CD5D01C15369@039-SN1MPN1-003.039d.mgd.msft.net>(from
 B38951@freescale.com on Tue Mar 12 02:40:39 2013)
 <1363123452.17135.13@snotra>
From: "David Laight" <David.Laight@ACULAB.COM>
To: "Scott Wood" <scottwood@freescale.com>,
 "Jia Hongtao-B38951" <B38951@freescale.com>
Cc: Wood Scott-B07421 <B07421@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 Stuart Yoder <b08248@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> Hmm, seems there's no probe_user_address() -- for userspace we
> basically want the same thing minus the KERNEL_DS.  See
> arch/powerpc/perf/callchain.c for an example.

Isn't that just copy_from_user() ?

	David

Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e7.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 47FEA2C00C8
 for <linuxppc-dev@ozlabs.org>; Sun, 12 May 2013 08:31:43 +1000 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Sat, 11 May 2013 18:31:40 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 2D8246E803F
 for <linuxppc-dev@ozlabs.org>; Sat, 11 May 2013 18:31:34 -0400 (EDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r4BMVanA331232
 for <linuxppc-dev@ozlabs.org>; Sat, 11 May 2013 18:31:37 -0400
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r4BMVaTb032169
 for <linuxppc-dev@ozlabs.org>; Sat, 11 May 2013 16:31:36 -0600
Date: Sat, 11 May 2013 15:31:11 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH] perf: Power7: Make CPI stack events available in sysfs
Message-ID: <20130511223111.GA30064@us.ibm.com>
References: <20130406164803.GA408@us.ibm.com>
 <20130415061508.GD21147@concordia>
 <20130422155505.GA26169@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130422155505.GA26169@us.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
 linux-kernel@vger.kernel.org,
 Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Sukadev Bhattiprolu [sukadev@linux.vnet.ibm.com] wrote:
| Michael Ellerman [michael@ellerman.id.au] wrote:
| | On Sat, Apr 06, 2013 at 09:48:03AM -0700, Sukadev Bhattiprolu wrote:
| | > From bdeacf7175241f6c79b5b2be0fa6b20b0d0b7d1c Mon Sep 17 00:00:00 2001
| | > From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
| | > Date: Sat, 6 Apr 2013 08:48:26 -0700
| | > Subject: [PATCH] perf: Power7: Make CPI stack events available in sysfs
| | > 
| | > A set of Power7 events are often used for Cycles Per Instruction (CPI) stack
| | > analysis. Make these events available in sysfs (/sys/devices/cpu/events/) so
| | > they can be identified using their symbolic names:
| | > 
| | > 	perf stat -e 'cpu/PM_CMPLU_STALL_DCACHE_MISS/' /bin/ls
| | 
| | Should we take these two via the powerpc tree? Or do you want to take
| | them Arnaldo?
| 
| I think it can go through powerpc tree since it is all arch-specific.
| 

Ben, Paul,

Any comments on this patch ?

	https://lkml.org/lkml/2013/4/6/169

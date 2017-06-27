Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wxlxS58sSzDr26
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Jun 2017 22:44:44 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Cc: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Subject: Re: [PATCH 0/8] Support for 24x7 hcall interface version 2
In-Reply-To: <1496350947-30951-1-git-send-email-bauerman@linux.vnet.ibm.com>
References: <1496350947-30951-1-git-send-email-bauerman@linux.vnet.ibm.com>
Date: Tue, 27 Jun 2017 22:44:41 +1000
Message-ID: <87injhd2h2.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com> writes:

> Hello,
>
> The hypervisor interface to access 24x7 performance counters (which collect
> performance information from system power on to system power off) has been
> extended in POWER9 adding new fields to the request and result element
> structures.
>
> Also, results for some domains now return more than one result element and
> those need to be added to get a total count.
>
> The first two patches fix bugs in the existing code. The following 4
> patches are code improvements and the last two finally implement support
> for the changes in POWER9 described above.
>
> POWER8 systems only support version 1 of the interface, while POWER9
> systems only support version 2. I tested these patches on POWER8 to verify
> that there are no regressions, and also on POWER9 DD1.

Where is version 2 documented?

And what happens when we boot on a POWER9 in POWER8 compatibility mode?

cheers

Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 8A7FE2C0087
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jul 2012 03:29:29 +1000 (EST)
Subject: Re: [PATCH v8 0/7] power management patch set
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <CADRPPNSw5Yn7EgHt5fm2vYr+zxC4T+JbsvT812u2JPKELNcA6g@mail.gmail.com>
Date: Thu, 26 Jul 2012 12:29:19 -0500
Message-Id: <B5854411-6C9A-43BA-BF5D-FB1AD76E28D1@kernel.crashing.org>
References: <1342788159-27529-1-git-send-email-chenhui.zhao@freescale.com>
 <CADRPPNSw5Yn7EgHt5fm2vYr+zxC4T+JbsvT812u2JPKELNcA6g@mail.gmail.com>
To: Li Yang <leoli@freescale.com>
Cc: scottwood@freescale.com, linuxppc-dev@lists.ozlabs.org,
 Zhao Chenhui <chenhui.zhao@freescale.com>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 26, 2012, at 9:02 AM, Li Yang wrote:

> On Fri, Jul 20, 2012 at 8:42 PM, Zhao Chenhui
> <chenhui.zhao@freescale.com> wrote:
>> Changes for v8:
>> * Separated the cpu hotplug patch into three patches, as follows
>> [PATCH v8 1/7] powerpc/smp: use a struct epapr_spin_table to replace =
macros
>> [PATCH v8 2/7] powerpc/smp: add generic_set_cpu_up() to set cpu_state =
as CPU_UP_PREPARE
>> [PATCH v8 4/7] powerpc/85xx: add HOTPLUG_CPU support
>>=20
>> * Replaced magic numbers with macros in "[PATCH 5/7] powerpc/85xx: =
add sleep and deep sleep support"
>>=20
>> * no change to the rest of the patch set
>=20
> Hi Kumar,
>=20
> How about picking about this series for 3.6?  The review seems to
> settle down for this revision.

Its too late for 3.6, but will look at queuing it up for 3.7.

> Hi Scott,
>=20
> Thanks for the review comments provided.  We'd like to get the ACK
> from you for the series if you can.
>=20
> Regards,
> Leo

- k=

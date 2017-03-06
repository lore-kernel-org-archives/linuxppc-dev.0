Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vcF660GkjzDqFh
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Mar 2017 20:36:14 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: benh@au1.ibm.com, bsingharora@gmail.com
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH v3] powerpc/xics: Work around limitations of OPAL XICS
 priority handling
In-Reply-To: <1488755402.2870.118.camel@au1.ibm.com>
References: <1488629006-17180-1-git-send-email-mpe@ellerman.id.au>
 <1488755402.2870.118.camel@au1.ibm.com>
Date: Mon, 06 Mar 2017 20:36:12 +1100
Message-ID: <87innmpx0z.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@au1.ibm.com> writes:

> On Sat, 2017-03-04 at 23:03 +1100, Michael Ellerman wrote:
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Allow "sufficient" time to=
 drop any inflight IRQ's */
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mdelay(1);
>> +
>
> According to the HW guys, that should be 5ms in case the powerbus is
> really really busy.

Is that a metric or imperial "really really" ?  :D

I'll fold in a change to 5ms, and rebase because it's going to stable.

cheers

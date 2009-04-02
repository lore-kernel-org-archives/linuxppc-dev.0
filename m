Return-Path: <glikely@secretlab.ca>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.30])
	by ozlabs.org (Postfix) with ESMTP id 685CFDDD1C
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Apr 2009 00:41:25 +1100 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so341181yxg.39
	for <linuxppc-dev@ozlabs.org>; Thu, 02 Apr 2009 06:41:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090402.005715.02030593.davem@davemloft.net>
References: <20090401060117.8641.32252.stgit@localhost.localdomain>
	<20090402.005715.02030593.davem@davemloft.net>
Date: Thu, 2 Apr 2009 07:41:23 -0600
Message-ID: <fa686aa40904020641k4db9e66dh4f80b5b32f68455d@mail.gmail.com>
Subject: Re: [PATCH 0/3] Series short description
From: Grant Likely <grant.likely@secretlab.ca>
To: David Miller <davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Apr 2, 2009 at 1:57 AM, David Miller <davem@davemloft.net> wrote:
> From: Grant Likely <grant.likely@secretlab.ca>
> Date: Wed, 01 Apr 2009 00:16:46 -0600
>
>> Here are the fec_mpc52xx patches which should be picked up for 2.6.29.
>> Patch #1 fixes a dma related BUG_ON() discovered after the merge window
>> opened. =A0#2 & #3 were original a single patch posted prior to the merg=
e
>> window, but not having a s-o-b line from the original author held them u=
p.
>> In the end I rewrote it from scratch as two patches just so I can get
>> them merged. =A0#2 makes the driver use net_device_ops, and #3 fixes a N=
ULL
>> dereference.
>>
>> I've tested these patches on several MPC5200 platforms.
>
> All applied, thanks Grant.

Thanks David!

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

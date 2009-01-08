Return-Path: <glikely@secretlab.ca>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.29])
	by ozlabs.org (Postfix) with ESMTP id 9447CDE2F3
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Jan 2009 15:53:08 +1100 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so2714031yxg.39
	for <linuxppc-dev@ozlabs.org>; Wed, 07 Jan 2009 20:53:07 -0800 (PST)
Message-ID: <fa686aa40901072053v7803c6afp206e0572a6c79eda@mail.gmail.com>
Date: Wed, 7 Jan 2009 21:53:07 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
To: "Matt Sealey" <matt@genesi-usa.com>
Subject: Re: [PATCH] powerpc/mpc52xx: Properly update irq_desc when set_type()
	is called.
In-Reply-To: <4965784D.6090704@genesi-usa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20090107192505.26320.23112.stgit@localhost.localdomain>
	<4965784D.6090704@genesi-usa.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jan 7, 2009 at 8:51 PM, Matt Sealey <matt@genesi-usa.com> wrote:
> Grant Likely wrote:
>>
>> From: Grant Likely <grant.likely@secretlab.ca>
>>
>> The MPC5200 PIC driver doesn't correctly update the .status field of
>> the irq_desc structure when the set_type hook is called.  This patch
>> adds the required code.
>>
>> Also cleans up the external IRQ typename field to be something easier
>> to read (very minor).
>>
>> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
>
> Hi Grant,
>
> What does this affect?

cat /proc/interrupts

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

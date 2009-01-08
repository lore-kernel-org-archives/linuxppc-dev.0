Return-Path: <neko@genesi-usa.com>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.249])
	by ozlabs.org (Postfix) with ESMTP id EF106DE6A1
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Jan 2009 01:39:59 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id d11so2706155and.39
	for <linuxppc-dev@ozlabs.org>; Thu, 08 Jan 2009 06:39:58 -0800 (PST)
Sender: Matt Sealey <neko@genesi-usa.com>
Message-ID: <49661041.2010302@genesi-usa.com>
Date: Thu, 08 Jan 2009 08:40:01 -0600
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] powerpc/mpc52xx: Properly update irq_desc when set_type()
	is called.
References: <20090107192505.26320.23112.stgit@localhost.localdomain>	
	<4965784D.6090704@genesi-usa.com>
	<fa686aa40901072053v7803c6afp206e0572a6c79eda@mail.gmail.com>
In-Reply-To: <fa686aa40901072053v7803c6afp206e0572a6c79eda@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Grant Likely wrote:
> On Wed, Jan 7, 2009 at 8:51 PM, Matt Sealey <matt@genesi-usa.com> wrote:
>> Grant Likely wrote:
>>> From: Grant Likely <grant.likely@secretlab.ca>
>>>
>>> The MPC5200 PIC driver doesn't correctly update the .status field of
>>> the irq_desc structure when the set_type hook is called.  This patch
>>> adds the required code.
>>>
>>> Also cleans up the external IRQ typename field to be something easier
>>> to read (very minor).
>>>
>>> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
>> Hi Grant,
>>
>> What does this affect?
> 
> cat /proc/interrupts

Ah so, completely cosmetic in the end. I was worried I'd have to build a 
new kernel for a second.. :D

-- Matt

Return-Path: <jwboyer@gmail.com>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.30])
	by ozlabs.org (Postfix) with ESMTP id A4ACEDDE22
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Dec 2008 23:06:00 +1100 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so1247763yxg.39
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Dec 2008 04:05:59 -0800 (PST)
Sender: Josh Boyer <jwboyer@gmail.com>
Date: Sat, 27 Dec 2008 07:05:43 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: add 16K/64K pages support for the 44x PPC32
	architectures.
Message-ID: <20081227120543.GA20406@zod.rchland.ibm.com>
References: <49406F61.2000004@emcraft.com>
	<1228960541-11407-1-git-send-email-yanok@emcraft.com>
	<20081217195607.GE3049@localhost.localdomain>
	<20081224170359.GA22129@zod.rchland.ibm.com>
	<1230326575.7292.41.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1230326575.7292.41.camel@pasglop>
Cc: Ilya Yanok <yanok@emcraft.com>, dzu@denx.de, linuxppc-dev@ozlabs.org,
	paulus@samba.org, Vladimir Panfilov <pvr@emcraft.com>, wd@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Dec 27, 2008 at 08:22:55AM +1100, Benjamin Herrenschmidt wrote:
>
>> >The code looks pretty clean now.  I think if we're going to include
>> >this patch it should go in now.
>> >
>> >Acked-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
>> 
>> Ben, Paul,
>> 
>> What else is needed to get this patch included?
>
>Can you remind us the pre-req ?

http://patchwork.ozlabs.org/patch/10951/

josh

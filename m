Return-Path: <tommusta@gmail.com>
Received: from mail-yh0-x235.google.com (mail-yh0-x235.google.com
 [IPv6:2607:f8b0:4002:c01::235])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9BE272C03A6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Oct 2013 06:35:37 +1100 (EST)
Received: by mail-yh0-f53.google.com with SMTP id z20so789264yhz.40
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Oct 2013 12:35:33 -0700 (PDT)
Message-ID: <52715F7F.8020206@gmail.com>
Date: Wed, 30 Oct 2013 14:35:27 -0500
From: Tom Musta <tommusta@gmail.com>
MIME-Version: 1.0
To: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH 1/3] powerpc: Enable emulate_step In Little Endian Mode
References: <1382125125.2206.22.camel@tmusta-sc.rchland.ibm.com>	<1382125235.2206.24.camel@tmusta-sc.rchland.ibm.com>
 <878uxairi8.fsf@igel.home>
In-Reply-To: <878uxairi8.fsf@igel.home>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: tmusta@gmail.com, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/30/2013 12:43 PM, Andreas Schwab wrote:
> Tom Musta <tommusta@gmail.com> writes:
>
>> +#ifdef __LITTLE_ENDIAN__
>> +	if (!regs->msr & MSR_LE)
>
> That won't work.
>
> Andreas.
>

Please elaborate.

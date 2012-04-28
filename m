Return-Path: <larry.finger@gmail.com>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
 [209.85.210.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 73C10B6FE9
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Apr 2012 09:30:47 +1000 (EST)
Received: by iakh37 with SMTP id h37so3023882iak.38
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Apr 2012 16:30:45 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <4F9C7DA2.7040203@lwfinger.net>
Date: Sat, 28 Apr 2012 18:30:42 -0500
From: Larry Finger <Larry.Finger@lwfinger.net>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Regression in 32-bit ppc kernel
References: <4F973026.3020103@lwfinger.net>
 <1335311621.15830.42.camel@pasglop> <4F976352.4060001@lwfinger.net>
 <1335327081.21961.28.camel@pasglop> <4F98117C.7080309@lwfinger.net>
 <1335390257.21961.53.camel@pasglop> <4F9ABD67.3060704@lwfinger.net>
 <1335565573.20866.7.camel@pasglop> <4F9B3398.9060701@lwfinger.net>
 <1335573757.20866.12.camel@pasglop> <4F9C3252.7020508@lwfinger.net>
 <m2y5pflnqk.fsf@igel.home> <1335653288.20866.15.camel@pasglop>
 <4F9C7A8E.1020009@lwfinger.net> <1335655416.20866.17.camel@pasglop>
In-Reply-To: <1335655416.20866.17.camel@pasglop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Paul Mackerras <paulus@samba.org>, Andreas Schwab <schwab@linux-m68k.org>,
 linuxppc-dev@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/28/2012 06:23 PM, Benjamin Herrenschmidt wrote:
> On Sat, 2012-04-28 at 18:17 -0500, Larry Finger wrote:
>> Yes, good catch by Andreas. That change does fix the problem.
>>
>> Ben - Do you want to fix the typos for open/not open with the same
>> patch?
>>
> Sure, if you're going to do a proper patch, by all means please fix
> those too :-)
>
> Does it fix all the occurrences of the problem for you ?

Yes. After the patch is applied, no more "nobody cared" IRQ messages.

I will prepare the patch and send it to you.

Larry

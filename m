Return-Path: <larry.finger@gmail.com>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
 [209.85.210.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2B66AB7075
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Apr 2012 10:52:12 +1000 (EST)
Received: by iakh37 with SMTP id h37so3945005iak.38
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Apr 2012 17:52:09 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <4F9DE236.60002@lwfinger.net>
Date: Sun, 29 Apr 2012 19:52:06 -0500
From: Larry Finger <Larry.Finger@lwfinger.net>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] tty/serial/pmac_zilog: Fix "nobody cared" IRQ message
References: <4F9C830D.8040906@lwfinger.net> <1335745382.20866.18.camel@pasglop>
In-Reply-To: <1335745382.20866.18.camel@pasglop>
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

On 04/29/2012 07:23 PM, Benjamin Herrenschmidt wrote:
> On Sat, 2012-04-28 at 18:53 -0500, Larry Finger wrote:
>
>>
>> Index: wireless-testing/drivers/tty/serial/pmac_zilog.c
>> ===================================================================
>> --- wireless-testing.orig/drivers/tty/serial/pmac_zilog.c	2012-04-28
>> 15:51:38.843723074 -0500
>> +++ wireless-testing/drivers/tty/serial/pmac_zilog.c	2012-04-28
>> 18:34:34.053900600 -0500
>
> Patch seems to be wrapped... I'll apply manually this time around but
> check your mailer settings :-)

Sorry about that. I don't usually send patches that way, and forgot to check for 
wrapping.

Larry

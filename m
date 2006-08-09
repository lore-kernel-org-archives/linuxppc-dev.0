Return-Path: <adgospod@gmail.com>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.230])
	by ozlabs.org (Postfix) with ESMTP id 5F41667B76
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 10 Aug 2006 06:51:06 +1000 (EST)
Received: by wx-out-0506.google.com with SMTP id t14so262074wxc
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 09 Aug 2006 13:51:05 -0700 (PDT)
Message-ID: <bdfc5d6e0608091351y45c9ce6na6298c3be38fbde1@mail.gmail.com>
Date: Wed, 9 Aug 2006 16:51:04 -0400
From: "Andy Gospodarek" <andy@greyhouse.net>
Sender: adgospod@gmail.com
To: "Jeff.Fellin@rflelect.com" <Jeff.Fellin@rflelect.com>
Subject: Re: Debugger suggestions
In-Reply-To: <OF434A2D5E.5C955B36-ON852571C5.00707735@rflelect.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <OF434A2D5E.5C955B36-ON852571C5.00707735@rflelect.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 8/9/06, Jeff.Fellin@rflelect.com <Jeff.Fellin@rflelect.com> wrote:
>
> Folks,
> I have a coworker  who is having a problem debugging a user-level program
> on the power-pc. The program works correctly on a Redhat Linux i386
> platform, but fails when writing to a socket on the power-pc, using Linux
> 2.4.18 (ancient, but unfortunately management doesn't agree with updating
> the product). Have any of you been able to use a debugger naitively or
> remotely with an embedded power-pc application?

I have used gdb natively and remotely on ppc without too much trouble.
 You may need to temporarily load some extra shared-libraries on the
box to get gdb or gdbserver going, but it should be doable without too
much trouble.

>
> Pointers to possible debuggers are greatly appreciated.
>
> Jeff Fellin
> RFL Electronics
> Jeff.Fellin@rflelect.com
> 973 334-3100, x 327
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>

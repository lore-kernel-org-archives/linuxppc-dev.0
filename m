Return-Path: <ygeorgie@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.173])
	by ozlabs.org (Postfix) with ESMTP id DA168DDE46
	for <linuxppc-dev@ozlabs.org>; Sun, 14 Jan 2007 05:28:42 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so970375ugf
	for <linuxppc-dev@ozlabs.org>; Sat, 13 Jan 2007 10:28:40 -0800 (PST)
Message-ID: <7cc53cfa0701131028y42ed2b9age0fccf29c35fd708@mail.gmail.com>
Date: Sat, 13 Jan 2007 19:28:39 +0100
From: yuraxa <ygeorgie@gmail.com>
To: "Andreas Schwab" <schwab@suse.de>
Subject: Re: ppc inline asm syntax
In-Reply-To: <je64bb6p2j.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <7cc53cfa0701130341x2dfdc8f1s9cb70ffa741fafb6@mail.gmail.com>
	<je64bb6p2j.fsf@sykes.suse.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> > Hi, i'm writing some inline assembly for ppc.
> > Grepping linux src code for examples i found syntax that i can't
> > understand, but as i can see it's frequently used.
>
> There is some documentation in the GCC internals manual, see
> <http://gcc.gnu.org/onlinedocs/gccint/Output-Template.html>.  The ppc
> specific operand modifiers are only documented in the GCC source, see
> print_operand in
> <http://gcc.gnu.org/viewcvs/trunk/gcc/config/rs6000/rs6000.c?view=markup>.
>
> Andreas.
>

Thanks a'lot, It helps! But may be you'll be so graceful to explain
more precisely?
I don't quite understand how the final string will look like...
For 'U' operand modifier the comment is:
/* Print `u' if this has an auto-increment or auto-decrement.  */
But for 'X' operand modifier there is no comment at all.

Thanks in advance,
Yury.

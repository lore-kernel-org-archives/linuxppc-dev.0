Return-Path: <sumedhtirodkar@gmail.com>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.169])
	by ozlabs.org (Postfix) with ESMTP id 5205FDDD1C
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Feb 2009 00:03:49 +1100 (EST)
Received: by wf-out-1314.google.com with SMTP id 27so2126545wfd.15
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Feb 2009 05:03:47 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <85a5c2010902230439n1096196dr519462513bc3910d@mail.gmail.com>
References: <d2b9ccd90902222354o2e42db77h2f86fda45b5483b6@mail.gmail.com>
	<85a5c2010902230439n1096196dr519462513bc3910d@mail.gmail.com>
Date: Mon, 23 Feb 2009 18:33:47 +0530
Message-ID: <d2b9ccd90902230503i4c2535d5lbd05b7ddeddf3192@mail.gmail.com>
Subject: Re: Problem with decrementer interrupt
From: sumedh tirodkar <sumedhtirodkar@gmail.com>
To: Matt Gessner <mgessner@gmail.com>, linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I am using PowerPC 7447A...I am trying to port SA-RTL on PowerPC...
I am using

bla <function_name>

from the assembly code to call the function in C file...This i am
doing from interrupt handler of the decrementer...
If any more details are required, please let me know...

Regards,
Sumedh

On Mon, Feb 23, 2009 at 6:09 PM, Matt Gessner <mgessner@gmail.com> wrote:
> You need to tell people what cpu you're using, what linux kernel, etc etc
> etc.
>
> Your email is otherwise completely useless.
>
> On Mon, Feb 23, 2009 at 2:54 AM, sumedh tirodkar <sumedhtirodkar@gmail.com>
> wrote:
>>
>> In the handler for decrementer interrupt...there is a call to a C
>> function...
>> Now if the call is removed...the decrementer interrupt works perfectly
>> fine...
>> But if the C function is present, then the decrementer interrupt stops
>> coming after say 5-6 times...
>> Not able to find any reasoning for the same...
>> Has anyone come across this kind of problem?If yes, am i missing
>> something?
>>
>> Regards,
>> Sumedh
>> _______________________________________________
>> Linuxppc-dev mailing list
>> Linuxppc-dev@ozlabs.org
>> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>
>

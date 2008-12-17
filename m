Return-Path: <rlefevre@gmail.com>
Received: from mail-qy0-f21.google.com (mail-qy0-f21.google.com
	[209.85.221.21]) by ozlabs.org (Postfix) with ESMTP id A1211DDF08
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Dec 2008 07:27:50 +1100 (EST)
Received: by qyk14 with SMTP id 14so122348qyk.9
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Dec 2008 12:27:49 -0800 (PST)
Message-ID: <4e0b9cb00812171227g47647d31ufaec827ddbab0232@mail.gmail.com>
Date: Wed, 17 Dec 2008 21:27:49 +0100
From: "Remi Lefevre" <rlefevre@gmail.com>
To: "Laurent Pinchart" <laurentp@cse-semaphore.com>
Subject: Re: FHCI driver adaptation for CPM2
In-Reply-To: <200812171633.58081.laurentp@cse-semaphore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <4e0b9cb00812170710n3374d558xab3584dc61980756@mail.gmail.com>
	<200812171633.58081.laurentp@cse-semaphore.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Hi Remi,

Hi Laurent,

> You will find my latest version of the CPM2 FHCI patch attached to this e=
-
> mail. I've never bothered to clean it as we decided to drop the USB host
> function from our device.

Thank you very much. Not clean is better than lost.

> This depends on the disk. Some will probably not check the SOF token, oth=
ers
> will do and behave strangely.
>
>> Also 40% seems quite a lot, even at 1000Hz interruptions, an idea how mu=
ch
>> does the CRC computation contribute in this CPU hogging ?
>
> I haven't measured that, but probably not much. The biggest CPU time eate=
r
> isn't the SOF generation interrupt but the USB packet handling code. The =
CPM2
> USB host controller is really too low-level to be usable (except maybe fo=
r
> specific applications). Comparing the OHCI/UHCI/EHCI and FHCI controllers=
 is
> akin to  bit like comparing a full 16550 UART with a software bit-bang
> implementation. You can get around with it, it might work for your specif=
ic
> application, but you shouldn't try a full speed 115200bds communication w=
hile
> computing a CPU-hungry physical simulation.

That's what I was afraid of. I now understand clearly why you didn't expect=
 that
much better performance with CPM3 in a past message
(http://ozlabs.org/pipermail/linuxppc-embedded/2008-May/030508.html).
Still, as you said, it can have some use for specific applications.

Do you remember the throughput you were able to reach with this cpu overhea=
d ?

> Laurent Pinchart
> CSE Semaphore Belgium

Kind regards,
R=E9mi Lef=E8vre

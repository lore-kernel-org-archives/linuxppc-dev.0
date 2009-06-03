Return-Path: <soni.trilok@gmail.com>
Received: from qw-out-2122.google.com (qw-out-2122.google.com [74.125.92.27])
	by ozlabs.org (Postfix) with ESMTP id 92FDFDDD01
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Jun 2009 01:54:54 +1000 (EST)
Received: by qw-out-2122.google.com with SMTP id 3so48167qwe.15
	for <linuxppc-dev@ozlabs.org>; Wed, 03 Jun 2009 08:54:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <9e4733910906030838o7313c311je3545cd974d3edd5@mail.gmail.com>
References: <4A255B21.8040002@gersys.de>
	<20090602171527.GA8745@oksana.dev.rtsoft.ru>
	<4A266FB2.2040902@gersys.de>
	<20090603132217.GA18353@oksana.dev.rtsoft.ru>
	<9e4733910906030838o7313c311je3545cd974d3edd5@mail.gmail.com>
Date: Wed, 3 Jun 2009 21:24:52 +0530
Message-ID: <5d5443650906030854h40e98ff9tb2bd23a0f5e8dec6@mail.gmail.com>
Subject: Re: PWM class? (was: Re: MPC52xx simple GPIO support)
From: Trilok Soni <soni.trilok@gmail.com>
To: Jon Smirl <jonsmirl@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Bill Gatliff <bgat@billgatliff.com>, ppc-dev <linuxppc-dev@ozlabs.org>,
	linux-kernel@vger.kernel.org, Stefan Strobl <nst@gersys.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Jon,

On Wed, Jun 3, 2009 at 9:08 PM, Jon Smirl <jonsmirl@gmail.com> wrote:
> On Wed, Jun 3, 2009 at 9:22 AM, Anton Vorontsov
> <avorontsov@ru.mvista.com> wrote:
>> On Wed, Jun 03, 2009 at 02:42:26PM +0200, Stefan Strobl wrote:
>> [...]
>>> The led class provides support for setting the brightness, which
>>> obviously the gpio driver doesn't support. The hardware (mpc52xx_gpt)
>>> would support it in PWM mode though. I'm now wandering how this could b=
e
>>> best implemented.
>>>
>>> 1) - Create some PWM class similar to the GPIO class
>>> =A0 =A0- Add support for PWM mode in mpc52xx_gpt.c that uses that PWM c=
lass
>>> =A0 =A0- And add an interface for the LED to use the PWM class
>>>
>>> 2) - Create an LED driver that accesses the mpc52xx_gpt directly.
>>>
>>> I think I would be overwhelmed trying to implement (1) but am confident
>>> to do (2). What do you think is the right approach?
>>
>> I'd suggest creating a generic PWM class, i.e. PWMLIB, alike to
>> GPIOLIB. (2) can be an acceptable approach for now, but for the
>> long-term solution (1) is the way to go.
>
> What happened to this one?
>
> http://ozlabs.org/pipermail/linuxppc-dev/2008-October/063562.html
>

Adding Bill to see if he has any updates.

--=20
---Trilok Soni
http://triloksoni.wordpress.com
http://www.linkedin.com/in/triloksoni

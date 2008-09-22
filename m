Return-Path: <sshtylyov@ru.mvista.com>
Message-ID: <48D77FCB.8000404@ru.mvista.com>
Date: Mon, 22 Sep 2008 15:21:47 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: solution to printk() blocking interrupts?
References: <9e4733910809211353k1f06fb5bi219c124d0c44b47a@mail.gmail.com>
	<9e4733910809211443l5638887aw856377d39fcca85c@mail.gmail.com>
In-Reply-To: <9e4733910809211443l5638887aw856377d39fcca85c@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello.

Jon Smirl wrote:

>> Does anyone have a solution to the problem of printk() to a serial
>> console blocking interrupts for too long? I'm losing interrupts I need
>> because my hardware is getting overrun.
>>     

   It's a strange piece of hardware that loses interrupts on getting 
overrun. :-)

WBR, Sergei

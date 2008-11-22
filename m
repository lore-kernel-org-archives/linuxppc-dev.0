Return-Path: <gianfranco.casanova@alice.it>
Received: from smtp-out112.alice.it (smtp-out112.alice.it [85.37.17.112])
	by ozlabs.org (Postfix) with ESMTP id 36B65DDDED
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Nov 2008 23:23:17 +1100 (EST)
Message-ID: <4927F7DF.6070605@alice.it>
Date: Sat, 22 Nov 2008 13:15:27 +0100
From: Gianfranco Casanova <gianfranco.casanova@alice.it>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: R: R: USB on lite5200 does not work.
References: <47602D18F269934AB73B7E550804A1E00213796C@FBCMST09V03.fbc.local>	<fa686aa40811200656g783947f5l609650b707c6c883@mail.gmail.com>	<47602D18F269934AB73B7E550804A1E00213796F@FBCMST09V03.fbc.local>	<fa686aa40811200749xd9f8701ud6ee9b77b4c21001@mail.gmail.com>	<47602D18F269934AB73B7E550804A1E002137973@FBCMST09V03.fbc.local>
	<fa686aa40811210659l3b9a4eefwf6eb59f66386d379@mail.gmail.com>
In-Reply-To: <fa686aa40811210659l3b9a4eefwf6eb59f66386d379@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Grant Likely ha scritto:
> On Fri, Nov 21, 2008 at 1:36 AM,  <gianfranco.casanova@alice.it> wrote:
>> The main HW difference between our board and lite5200 is:
>> console on PSC3 and
> [...]
>> on our HW defined as:
>>         /* Radionav configuration */
>>         port_config =  0x0C712E66;
>>
> 
> You've got quite a bit of difference than just console on PSC3.  USB
> is on the Ethernet pin group instead of on the USB pin group.  Does
> the kernel change the value of port_config when it boots, or does it
> leave the value setup by U-Boot intact?

As far as I sow from debugger no.

We are able to boot with a mini operating system (see previous post). 
Plugging USB the system get frozen.

We have got the same version of kernel compiled on PPC ARCH and USB, in 
this case, works.

Between PPC and PowerPC from debugger there is only one difference the 
label for USB interrupt, in PPC is 50 in PowerPC is 134.

I've already checked CDM register and GPIO register and all are the same.

 From USB register only one difference on HDDC values (not important 
from my point of view).

Our processor frequency is different from lite5200. We are thinking that 
scaling frequency processor to determine frequency of USB bus is 
different in PPC and PowerPC. Other street we are looking for is some WR 
  patchs from lite5200 on PowerPC that are not accepted from our HW.

>> I still do not understand our bug with USB.
>> Have you got some suggestions or some test to be performed in order to find
>> out a solutions?
> 
> Not over a quick exchange via email. 

Yes of course :)

> Your kernel is too old and USB
> debugging can be complex.  I'd need to be working with your hardware
> to figure out what is going on.

I see. We also wont debug USB.
Thaks J

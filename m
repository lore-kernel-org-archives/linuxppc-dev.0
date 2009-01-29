Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id DD622DDFAB
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Jan 2009 20:38:25 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1LSTLo-0006FK-OK
	for linuxppc-dev@ozlabs.org; Thu, 29 Jan 2009 01:38:20 -0800
Message-ID: <21723361.post@talk.nabble.com>
Date: Thu, 29 Jan 2009 01:38:20 -0800 (PST)
From: velumani <velumani.t@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: R: R: USB on lite5200 does not work.
In-Reply-To: <9e4733910811220735o378f785arfa3b577b2420f213@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <47602D18F269934AB73B7E550804A1E00213796C@FBCMST09V03.fbc.local>
	<fa686aa40811200656g783947f5l609650b707c6c883@mail.gmail.com>
	<fa686aa40811200749xd9f8701ud6ee9b77b4c21001@mail.gmail.com>
	<47602D18F269934AB73B7E550804A1E002137973@FBCMST09V03.fbc.local>
	<fa686aa40811210659l3b9a4eefwf6eb59f66386d379@mail.gmail.com>
	<4927F7DF.6070605@alice.it>
	<9e4733910811220735o378f785arfa3b577b2420f213@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi,

Did you get any solution for this problem. We are also facing this issue...

This problem does not happen in our board on every reboot but happens
occationaly. If you have got any solution please let me know.

Thanks,
Velumani

Jon Smirl wrote:
> 
> If you are using a 33.333Mz crystal it is not possible to generate
> exactly 48Mhz for USB. Best you can do is 48.11Mz. With a 33Mhz
> crystal you can make 48Mhz exactly. But that's probably not your
> problem, that just results in errors on the USB bus. Some USB devices
> don't care and others will get errors.
> 
> On Sat, Nov 22, 2008 at 7:15 AM, Gianfranco Casanova
> <gianfranco.casanova@alice.it> wrote:
>> Grant Likely ha scritto:
>>>
>>> On Fri, Nov 21, 2008 at 1:36 AM,  <gianfranco.casanova@alice.it> wrote:
>>>>
>>>> The main HW difference between our board and lite5200 is:
>>>> console on PSC3 and
>>>
>>> [...]
>>>>
>>>> on our HW defined as:
>>>>        /* Radionav configuration */
>>>>        port_config =  0x0C712E66;
>>>>
>>>
>>> You've got quite a bit of difference than just console on PSC3.  USB
>>> is on the Ethernet pin group instead of on the USB pin group.  Does
>>> the kernel change the value of port_config when it boots, or does it
>>> leave the value setup by U-Boot intact?
>>
>> As far as I sow from debugger no.
>>
>> We are able to boot with a mini operating system (see previous post).
>> Plugging USB the system get frozen.
>>
>> We have got the same version of kernel compiled on PPC ARCH and USB, in
>> this
>> case, works.
>>
>> Between PPC and PowerPC from debugger there is only one difference the
>> label
>> for USB interrupt, in PPC is 50 in PowerPC is 134.
>>
>> I've already checked CDM register and GPIO register and all are the same.
>>
>> From USB register only one difference on HDDC values (not important from
>> my
>> point of view).
>>
>> Our processor frequency is different from lite5200. We are thinking that
>> scaling frequency processor to determine frequency of USB bus is
>> different
>> in PPC and PowerPC. Other street we are looking for is some WR  patchs
>> from
>> lite5200 on PowerPC that are not accepted from our HW.
>>
>>>> I still do not understand our bug with USB.
>>>> Have you got some suggestions or some test to be performed in order to
>>>> find
>>>> out a solutions?
>>>
>>> Not over a quick exchange via email.
>>
>> Yes of course :)
>>
>>> Your kernel is too old and USB
>>> debugging can be complex.  I'd need to be working with your hardware
>>> to figure out what is going on.
>>
>> I see. We also wont debug USB.
>> Thaks J
>> _______________________________________________
>> Linuxppc-dev mailing list
>> Linuxppc-dev@ozlabs.org
>> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>>
> 
> 
> 
> -- 
> Jon Smirl
> jonsmirl@gmail.com
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
> 
> 

-- 
View this message in context: http://www.nabble.com/USB-on-lite5200-does-not-work.-tp20601948p21723361.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.

Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8FD9E67B7F
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  3 May 2006 05:50:44 +1000 (EST)
In-Reply-To: <DDBD7B17DB2ECE48BCD94C593F7255B401551C7C@monk.echelon.echcorp.com>
References: <DDBD7B17DB2ECE48BCD94C593F7255B401551C7C@monk.echelon.echcorp.com>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <BCAE05B9-1AD6-44A8-B9AB-B44D16D89B4D@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: USB on MPC8349EMDS
Date: Tue, 2 May 2006 14:50:31 -0500
To: Prashant Viswanathan <vprashant@echelon.com>
Cc: "linuxppc-embedded \(\(\(\(E-Mail\)\)\)\)" <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On May 2, 2006, at 1:52 PM, Prashant Viswanathan wrote:

>>> When I insert a USB Mass storage device (thumb drive), I get the
>>> following errors
>>>
>>> / #  usb 1-2: new high speed USB device using fsl-usb2-mph and
>>> address 8
>>> usb 1-2: khubd timed out on ep0in
>>> usb 1-2: new high speed USB device using fsl-usb2-mph and address 9
>>> usb 1-2: khubd timed out on ep0in
>>>
>>> It does not show up in /proc/bus/usb/devices (I do have usbfs
>>> mounted).
>>>
>>> I also have usb-utils installed and lsusb fails to list the device.
>>>
>>> I have also tried other USB devices and get similar errors.
>>>
>>> Has anybody else experience similar problems? Any pointers/help
>>> will be
>>> appreciated.
>>
>> I know there are some bugs in the Freescale driver that was released
>> as part of their BSP.
>>
>> Are you using a PMC2USB module or just the USB ports on the SYS card?
>>
>> - k
>
> I am connecting to the USB port on the board using the USB adaptor. I
> tried both configurations (MPH and DR).
>
> I also tried the latest stable kernel (2.6.16.12) but that doesn't
> compile for this board. Is there a later (later than 2.16.11)  
> kernel out
> there which works for this particular board?
>
> Another possibility might be that the eval board I have is bad. I  
> can't
> seem to get my hands on the errata.

You'll need something like 2.6.16 plus a patch from Randy Vinson  
(posted to the list a month or two ago).

- kumar

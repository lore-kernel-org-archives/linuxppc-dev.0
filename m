Return-Path: <j.lu@tiesse.com>
Received: from tiesse.com (studiogesan.it [193.76.202.5])
	by ozlabs.org (Postfix) with ESMTP id C98B167B36
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 22 Jun 2005 16:56:56 +1000 (EST)
Date: Wed, 22 Jun 2005 09:00:27 +0200
Message-Id: <200506220900.AA129434516@tiesse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: "Jianliang Lu" <j.lu@tiesse.com>
To: <j.lu@tiesse.com>,
    Wolfgang Denk  <wd@denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: isp1362 usb driver 
Reply-To: j.lu@tiesse.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,
the device is a adsl modem, it works correctly in other linux 
systems with kernel 2.4.2x. The problem is that the isp1362 driver 
seems that supports only isochronous endpoints. We are 
implementing the code to support also control/bulk/interrupt 
endpoints.

Regards,
Jianliang Lu

---------- Original Message ----------------------------------
From: Wolfgang Denk <wd@denx.de>
Date: Tue, 21 Jun 2005 22:18:34 +0200

>Hello,
>
>in message <200506211648.AA102695630@tiesse.com> you wrote:
>>
>> sorry for my persistence, now I try to go to more detail:
>
>I'm afraid I can't help much. The only board with a  ISP1362  I  
have
>access  to at the moment has just the device interface equipped, 
so I
>cannot run any real tests on the host port.
>
>> Jan  1 01:01:30 IMOLA kernel: hub.c: USB new device connect on 
>> bus2/2, assigned device number 2
>> Jan  1 01:01:33 IMOLA kernel: usb_control/bulk_msg: timeout
>> Jan  1 01:01:45 IMOLA last message repeated 4 times
>> Jan  1 01:01:45 IMOLA kernel: usb.c: couldn't get all of config 
>> descriptors
>> Jan  1 01:01:45 IMOLA kernel: usb.c: unable to get device 2 
>> configuration (error=-110)
>
>Which sort of device is it what you connected? Are  you  sure  
it  is
>working  under  Linux at all? Did you test it on a standard x86 
Linux
>PC with a 2.4.2x kernel?
>
>
>Best regards,
>
>Wolfgang Denk
>
>-- 
>Software Engineering:  Embedded and Realtime Systems,  Embedded 
Linux
>Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: 
wd@denx.de
>A fanatic is a person who can't change his mind and won't change  
the
>subject.                                          - Winston 
Churchill
>
                   

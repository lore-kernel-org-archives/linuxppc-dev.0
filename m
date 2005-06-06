Return-Path: <wojciech.kromer@dgt.com.pl>
Received: from dgt.com.pl (mail.dgt.com.pl [195.117.141.2])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 462A3679F3
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  6 Jun 2005 16:08:33 +1000 (EST)
Received: from mail.dgt.com.pl (localhost [127.0.0.1])
	by dgt.com.pl (Postfix) with SMTP id 1AF5557869
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  6 Jun 2005 08:08:25 +0200 (CEST)
Received: from [192.168.7.66] (proxy.dgt.com.pl [::ffff:195.117.141.11])
	by dgt.com.pl (Postfix) with ESMTP id 1A9D950458
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  6 Jun 2005 08:08:24 +0200 (CEST)
Message-ID: <42A3E880.6030309@dgt.com.pl>
Date: Mon, 06 Jun 2005 08:09:04 +0200
From: Wojciech Kromer <wojciech.kromer@dgt.com.pl>
MIME-Version: 1.0
To: undisclosed-recipients: ;
Content-Type: multipart/mixed; boundary="------------080404000807000706010502"
Subject: [Fwd: Re: Getting ownership for various boards/platforms configs]
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------080404000807000706010502
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



--------------080404000807000706010502
Content-Type: message/rfc822;
	name="Re: Getting ownership for various boards/platforms configs"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="Re: Getting ownership for various boards/platforms configs"

Return-Path: <acurtis@onz.com>
Delivered-To: wojciech.kromer@dgt.com.pl
Received: from mail.dgt.com.pl (localhost [127.0.0.1])
	by dgt.com.pl (Postfix) with SMTP id B071D5795C
	for <wojciech.kromer@dgt.com.pl>; Fri,  3 Jun 2005 16:27:45 +0200 (CEST)
Received: from dell2650.onz.com (onz.com [::ffff:67.121.61.113])
	by dgt.com.pl (Postfix) with ESMTP id 162505785B
	for <wojciech.kromer@dgt.com.pl>; Fri,  3 Jun 2005 16:27:45 +0200 (CEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by dell2650.onz.com (Postfix) with ESMTP id 5504D2B4159
	for <wojciech.kromer@dgt.com.pl>; Fri,  3 Jun 2005 07:27:41 -0700 (PDT)
Received: from dell2650.onz.com ([127.0.0.1])
	by localhost (dell2650.onz.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 05987-03 for <wojciech.kromer@dgt.com.pl>;
	Fri,  3 Jun 2005 07:27:40 -0700 (PDT)
Received: from [192.168.1.101] (unknown [192.168.1.1])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by dell2650.onz.com (Postfix) with ESMTP id B66E52B413C
	for <wojciech.kromer@dgt.com.pl>; Fri,  3 Jun 2005 07:27:40 -0700 (PDT)
Mime-Version: 1.0 (Apple Message framework v622)
In-Reply-To: <429FFB53.2040106@dgt.com.pl>
References: <bf0d9d49e4c115e67aa5df39e33017a1@freescale.com>
	<429FFB53.2040106@dgt.com.pl>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <efe74c750b938026bd9564214c19a598@onz.com>
Content-Transfer-Encoding: 7bit
From: Allen Curtis <acurtis@onz.com>
Subject: Re: Getting ownership for various boards/platforms configs
Date: Fri, 3 Jun 2005 07:27:41 -0700
To: Wojciech Kromer <wojciech.kromer@dgt.com.pl>
X-Mailer: Apple Mail (2.622)
X-Virus-Scanned: by amavisd-new at onz.com

If you are looking for maintainers, I will work on the PPC stuff. The 
#ifdef situation has been out of control for quite some time. I did 
attempt to consolidate the platform stuff. Some of this work did make 
it into the kernel. Are you talking about 2.6? I was about to work on 
the sysfs stuff which will go a long way to cleaning up the device 
drivers.

BTW: the linuxppc-embedded list did not show in the reply list. Forward 
this if you want.

>> One issue that comes up from time to time is knowing who to contact 
>> about some of the various boards that are supported for PPC. I've 
>> suggested in the past that we create a MAINTAINERS file in 
>> arch/ppc/platforms. I've started with a list of all the _defconfigs 
>> that we have and would like to see if we can get contacts for the 
>> boards. All this list is meant to be is a contact point.
>>
>>
> There is another issue..
>
> May I suggest to add one full-custom board?
> There are a lot of changes to do inside uart,fec,fcc drivers with a lot
> of #ifdefs,
> just because different use of mpc resources on different boards.
> Why it's not configured via menuconfig?
> Another nice example is inside status_led.h...




--------------080404000807000706010502--

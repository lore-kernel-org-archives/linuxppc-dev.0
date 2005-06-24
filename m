Return-Path: <kevdig@hypersurf.com>
Received: from mail.hypersurf.com (mail.hypersurf.com [209.237.0.6])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8274367B58
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Jun 2005 14:10:10 +1000 (EST)
Received: from hypersurf.com (DIALPAT65.hypersurf.com [206.40.42.65])
	by mail.hypersurf.com (8.13.1/8.13.1) with ESMTP id j5O3tUex070602
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Jun 2005 20:55:50 -0700 (PDT)
Message-ID: <42BB83D9.8040809@hypersurf.com>
Date: Thu, 23 Jun 2005 20:54:01 -0700
From: Kevin Diggs <kevdig@hypersurf.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Content-Type: multipart/mixed; boundary="------------000402010702020809050801"
Subject: [Fwd: Re: 750GX HID1 sysctl interface]
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------000402010702020809050801
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Kumar Gala wrote:
> Kevin,
> 
> You may want to post this on the linuxppc-dev lists (linuxppc- 
> dev@ozlabs.org)
> 
> - kumar
> 
> On Jun 23, 2005, at 8:16 PM, Kevin Diggs wrote:
> 
>> Hi,
>>
>>     I have added support to version 2.4.30 of the kernel to control
>> the PLL
>> configuration register (HID1) in the IBM PowerPC 750GX via the sysctl
>> (and /proc/sys/kernel) mechanism.
>>
>>     Is there any interest in this? If so, ... uh ... how do I
>> generate the
>> patches and submit them?
>>
>>                     kevin
>> -
>> To unsubscribe from this list: send the line "unsubscribe linux- kernel"
>> in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
>>
> 
> 


--------------000402010702020809050801
Content-Type: message/rfc822;
 name="Re: 750GX HID1 sysctl interface"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Re: 750GX HID1 sysctl interface"

Return-Path: <kumar.gala@freescale.com>
Received: from postman2.hypersurf.com (postman2.hypersurf.com [209.237.60.18])
	by mail.hypersurf.com (8.13.1/8.13.1) with ESMTP id j5O2avg1066236
	for <kevdig@hypersurf.com>; Thu, 23 Jun 2005 19:36:57 -0700 (PDT)
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	by postman2.hypersurf.com (8.13.1/8.13.1) with ESMTP id j5O2auoZ093492
	for <kevdig@hypersurf.com>; Thu, 23 Jun 2005 19:36:57 -0700 (PDT)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	j5O2fdda005435; Thu, 23 Jun 2005 19:41:39 -0700 (MST)
Received: from [192.168.123.103] ([10.214.73.25])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id j5O2csdC026199;
	Thu, 23 Jun 2005 21:38:55 -0500 (CDT)
In-Reply-To: <42BB5EDE.8070402@hypersurf.com>
References: <42BB5EDE.8070402@hypersurf.com>
Mime-Version: 1.0 (Apple Message framework v730)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <5CE74F3F-3125-45C4-8616-49AF244D2097@freescale.com>
Cc: <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Kumar Gala <kumar.gala@freescale.com>
Subject: Re: 750GX HID1 sysctl interface
Date: Thu, 23 Jun 2005 21:36:45 -0500
To: Kevin Diggs <kevdig@hypersurf.com>
X-Mailer: Apple Mail (2.730)

Kevin,

You may want to post this on the linuxppc-dev lists (linuxppc- 
dev@ozlabs.org)

- kumar

On Jun 23, 2005, at 8:16 PM, Kevin Diggs wrote:

> Hi,
>
>     I have added support to version 2.4.30 of the kernel to control
> the PLL
> configuration register (HID1) in the IBM PowerPC 750GX via the sysctl
> (and /proc/sys/kernel) mechanism.
>
>     Is there any interest in this? If so, ... uh ... how do I
> generate the
> patches and submit them?
>
>                     kevin
> -
> To unsubscribe from this list: send the line "unsubscribe linux- 
> kernel"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>



--------------000402010702020809050801--

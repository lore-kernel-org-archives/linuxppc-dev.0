Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BAE80DDEFD
	for <linuxppc-dev@ozlabs.org>; Sat, 19 May 2007 02:26:39 +1000 (EST)
In-Reply-To: <20070518171555.543f9bdc@hyperion.delvare>
References: <20070517143846.GC29795@ld0162-tx32.am.freescale.net>
	<FB8DD3C1-A095-4ABB-9E74-7EC66A43D983@kernel.crashing.org>
	<464C800C.20400@freescale.com>
	<FFBD3A3A-ADBE-4DC8-A1A1-4163367244D5@kernel.crashing.org>
	<464C871C.4090300@freescale.com>
	<5B363A90-5528-4441-BBF9-9C6D8833D938@kernel.crashing.org>
	<20070518171555.543f9bdc@hyperion.delvare>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <D50C4D36-CEA5-4F7F-8A4C-CC747DF85865@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [i2c] [PATCH 3/5] powerpc: Document device nodes for I2C devices.
Date: Fri, 18 May 2007 11:24:57 -0500
To: Jean Delvare <khali@linux-fr.org>
Cc: linuxppc-dev@ozlabs.org, i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 18, 2007, at 10:15 AM, Jean Delvare wrote:

> Hi Kumar,
>
> On Thu, 17 May 2007 12:21:02 -0500, Kumar Gala wrote:
>> The only support we have for i2c controllers is to support one
>> specific i2c controller from Freescale.
>>
>> If you aren't going to provide a complete solution why are you
>> prosing one?  I'm tired of this put stuff in the device tree but only
>> as much as I need to do my particular thing.
>
> This is exactly how free software development works. If people were
> only proposing complete solutions, Linux would not even exist. Things
> happen exactly because people write what they need and contribute what
> they wrote. If you think it's not enough for your own needs  
> (present or
> future), then _you_ get to do the extra work.

I guess my gripe is about proposing a solution and not willing to  
extend it in light of people providing issues with it.  Last time I  
check we don't put things into the kernel w/o any review and if  
people have issues that are reasonable they get hashed out.  It seems  
that the onus is on the initial submitter to either show that what  
they are providing is sufficient and w/o issue or incorporate the  
feedback.

More specifically, we have a way to specify what devices are connect  
on I2C today.  I'm not convinced there is any value in creating yet  
another mechanism, especially in an interface that in theory should  
be linux agnostic.

- k

Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DEC2D67B8B
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Sep 2006 02:36:40 +1000 (EST)
In-Reply-To: <a0bc9bf80609280909r13e9ea31ldf0630969416cbff@mail.gmail.com>
References: <451B8553.30107@freescale.com>
	<7178D84E-0290-4D3E-905E-C26C9908F40E@kernel.crashing.org>
	<a0bc9bf80609280909r13e9ea31ldf0630969416cbff@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <98C2C73A-F57B-49A6-9727-D76A1AE9746C@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 0/12] Add support for QE and 8360EMDS board -v2
Date: Thu, 28 Sep 2006 11:37:10 -0500
To: "Li Yang" <LeoLi@freescale.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 28, 2006, at 11:09 AM, Li Yang wrote:

> On 9/28/06, Kumar Gala <galak@kernel.crashing.org> wrote:
>>
>> On Sep 28, 2006, at 3:18 AM, Li Yang wrote:
>>
>> > Paul,
>> >
>> > The series of patches add generic QE infrastructure called
>> > qe_lib, and MPC8360EMDS board support.  Qe_lib is used by
>> > QE device drivers such as ucc_geth driver.
>> >
>> > This version updates QE interrupt controller to use new irq
>> > mapping mechanism, addresses all the comments received with
>> > last submission and includes some style fixes.
>> >
>> > v2 change: Change to use device tree for BCSR and MURAM;
>> > Remove I/O port interrupt handling code as it is not generic
>> > enough.
>>
>> Before accepting any of this code, I'd like to see what the drivers
>> look like that are using it.  Its hard to make significant  
>> comments w/
>> o seeing what the consumers of all the 'lib' code look like.
>
> Current in-tree user of the lib is driver/net/ucc_geth.c.  There is
> also QE ATM driver which is included in Alex's 8360sar project.  QE
> USB host/client drivers are in Freescale LTIB BSP.

is there a serial driver?

- k

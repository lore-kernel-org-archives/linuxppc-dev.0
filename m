Return-Path: <mgreer@mvista.com>
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by ozlabs.org (Postfix) with ESMTP id 99D9C67A6E
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 23 Feb 2005 10:04:07 +1100 (EST)
Message-ID: <421BBA60.7030105@mvista.com>
Date: Tue, 22 Feb 2005 16:04:00 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: "Mark A. Greer" <mgreer@mvista.com>
References: <421B4126.1070808@katalix.com> <421BB1CB.1070803@mvista.com>
In-Reply-To: <421BB1CB.1070803@mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: mv64x60 patches for Radstone PPC7D - for review
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Mark A. Greer wrote:

> Hi James.
>
> James Chapman wrote:
>
>>
>> p5 - add extern i8259_pic_irq_offset 
>
>
>
> XXXX


Oops, hit send to soon.

This looks okay but in your platform file, you never set it anyway so 
you don't need to access it in there.

Mark

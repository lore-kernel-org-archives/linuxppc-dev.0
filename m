Return-Path: <mgreer@mvista.com>
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by ozlabs.org (Postfix) with ESMTP id 867D567A6D
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 21 Apr 2005 03:47:05 +1000 (EST)
Message-ID: <42669592.6080602@mvista.com>
Date: Wed, 20 Apr 2005 10:46:58 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: Sam Song <samlinuxppc@yahoo.com.cn>
References: <20050420135401.29160.qmail@web15808.mail.cnb.yahoo.com>
In-Reply-To: <20050420135401.29160.qmail@web15808.mail.cnb.yahoo.com>
Content-Type: text/plain; charset=GB2312
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: 824x Sandpoint with 2.6.x
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Sam Song wrote:

>"Mark A. Greer" <mgreer@mvista.com> wrote:
>  
>
>>>Kernel command line:
>>>console=uart,mmio,0xfdfce500,115200n8
>>>console=ttyS0,115200
>>>root=/dev/ram rw ramdisk_size=200000
>>>ip=192.168.0.3:192.168..2:::sandpoint:et
>>>h0:off panic=1
>>>
>>>      
>>>
>><snip>
>>
>>Get rid of the
>>"console=uart,mmio,0xfdfce500,115200n8" part of the
>>cmdline and see what happens (keep the
>>"console=ttyS0,115200" part).
>>    
>>
>
>If so, kernel will hang after loading the kernel......
>

Okay, obviously something is wrong. Adding another console line isn't
fixing anything, its just allowing you to flounder on a little further.
IMHO, adding another console line isn't going to help and will only add
confusion.

>I cannot see any active info.Is early console output 
>message not enough to find out something useful? 
>  
>

Sure it does. You have to enable it, then add some progress lines to
help narrow down where you're panic'ing/hanging. You can even use the
progress facility to dump the __log_buf.

I'm taking your unwillingness to use a jtag/cops debugger as indication
that you don't have such a tool!?!?

Mark

Return-Path: <jwboyer@gmail.com>
Received: from mail-yw0-f179.google.com (mail-yw0-f179.google.com
	[209.85.211.179])
	by bilbo.ozlabs.org (Postfix) with ESMTP id 88011B7BD4
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 31 Jul 2009 12:38:38 +1000 (EST)
Received: by ywh10 with SMTP id 10so1371806ywh.7
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 30 Jul 2009 19:38:35 -0700 (PDT)
Sender: Josh Boyer <jwboyer@gmail.com>
Date: Thu, 30 Jul 2009 22:38:32 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH] Add support for the ESTeem 195E (PPC405EP) SBC
Message-ID: <20090731023832.GC28607@hansolo.jdub.homelinux.org>
References: <1248448916-29473-1-git-send-email-solomon@linux-wlan.com>
	<20090730140630.GD10244@zod.rchland.ibm.com>
	<20090730194506.GA30066@linux-wlan.com>
	<20090730200848.GF10244@zod.rchland.ibm.com>
	<20090731004524.GA10243@yookeroo.seuss>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090731004524.GA10243@yookeroo.seuss>
Cc: linuxppc-dev@lists.ozlabs.org, Solomon Peachy <solomon@linux-wlan.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jul 31, 2009 at 10:45:24AM +1000, David Gibson wrote:
>On Thu, Jul 30, 2009 at 04:08:49PM -0400, Josh Boyer wrote:
>> On Thu, Jul 30, 2009 at 03:45:06PM -0400, Solomon Peachy wrote:
>> >On Thu, Jul 30, 2009 at 10:06:30AM -0400, Josh Boyer wrote:
>[snip]
>> >> >+			UART0: serial@ef600400 {
>> >> >+				device_type = "serial";
>> >> >+				compatible = "ns16550";
>> >> >+				reg = <0xef600400 0x00000008>;
>> >> >+				virtual-reg = <0xef600400>;
>> >> >+				clock-frequency = <0>; /* Filled in by zImage */
>> >> >+				current-speed = <0x9600>;
>> >> 
>> >> Just a question, but is the baud supposed to be 38400 or 9600?  At first glance
>> >> it almost seems like a typo :).
>> >
>> >It's supposed to be 38400 baud, hence the explicit 0x in front.  (I lost 
>> >count of the number of times I saw '38400' listed in various dts 
>> >files...)
>> 
>> Cool.  Just checking.
>
>Um.. except, surely it's clearer to just list 38400 in decimal, rather
>than 0x9600 which people are very likely to misread as 9600.

That was my point, yes.  It is clearer, yes.  It's his board though, so I'm
not going to nit-pick about it.

josh

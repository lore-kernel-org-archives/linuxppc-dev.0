Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 07A33DDE17
	for <linuxppc-dev@ozlabs.org>; Mon,  9 Jul 2007 22:41:51 +1000 (EST)
Message-ID: <46922D86.5040305@ru.mvista.com>
Date: Mon, 09 Jul 2007 16:43:50 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 2/5] Add legacy devices to mpc8641_hpcn.dts
References: <1179245829.8132.100.camel@rhino>
	<1179246470.8132.112.camel@rhino>	<1179333421.7018.17.camel@ld0161-tx32>
	<b77c4b3dd22795a73cd32a0623722e51@kernel.crashing.org>
	<468FDB8F.4050007@ru.mvista.com>
	<3D4AB802-A3D2-46CC-9BD1-1064EE0AC84C@kernel.crashing.org>
In-Reply-To: <3D4AB802-A3D2-46CC-9BD1-1064EE0AC84C@kernel.crashing.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello.

Segher Boessenkool wrote:
>>>>> +                8042@60 {
>>>>> +                    device_type = "8042";

>>> Drop the device_type.  A number as a name isn't
>>> all that great, either.

>>   Yet it's kinda accepted years ago, see:

>> http://playground.sun.com/1275/proposals/Closed/Accepted/381-it.txt

> That's not a published recommendation or anything like that.

    There's also this document with a status of "unapproved draft":

http://playground.sun.com/1275/bindings/devices/html/8042.html

    So, all this never got final approval? Somewhat confusing (well, what one 
could expect from OF? :-)

> Segher

WBR, Sergei

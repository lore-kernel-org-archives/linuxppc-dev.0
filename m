Return-Path: <scottwood@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id ABDFB67D88
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Dec 2006 05:35:02 +1100 (EST)
Message-ID: <458047D3.8060401@freescale.com>
Date: Wed, 13 Dec 2006 12:34:59 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Vijay Sampath <vsampath@gmail.com>
Subject: Re: Problem porting linux 2.6 on IBM405EP based boards
References: <758a2bbf0612130926w56d468dejf0e8e51c918d2175@mail.gmail.com>
In-Reply-To: <758a2bbf0612130926w56d468dejf0e8e51c918d2175@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Vijay Sampath wrote:
> After this, the code started executing start_kernel, but stopped
> shortly thereafter (snippet B). After this every time I press a key,
> the following line gets printed:
> 
> $T0740:30300a00;01:c0621fb0;#45
> 
> Its possible that I have something configured wrong, but
> any guidance on what that message could possibly mean would be
> appreciated.

That looks like output from a GDB stub.  You may want to try turning off 
GDB support in your kernel in order to (probably) get an oops message 
instead (you may need to do something special to hook printk up to the 
early debug console).  Alternately, you could try attaching to it with GDB.

-Scott

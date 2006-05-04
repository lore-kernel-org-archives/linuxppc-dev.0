Return-Path: <markc@mail.com>
Received: from smtp1.us4.outblaze.com (smtp1.us4.outblaze.com [205.158.62.78])
	by ozlabs.org (Postfix) with SMTP id 7CB5667A2E
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  5 May 2006 06:13:55 +1000 (EST)
Message-ID: <016d01c66fb7$3e815740$6601a8c0@CHUCK2>
From: "Mark Chambers" <markc@mail.com>
To: "Steve Iribarne \(GMail\)" <netstv@gmail.com>
References: <b4b98b690605030711q69426a59j28db8e38be73f1f0@mail.gmail.com><4459C774.8000300@dlasys.net>
	<b4b98b690605041251s40f88731i1edfdfb324da38b4@mail.gmail.com>
Subject: Re: kernel debugging
Date: Thu, 4 May 2006 16:13:42 -0400
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1";
	reply-type=original
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

>> >
>> > This is more a general question to see what others do out here.  I am
>> > begining to get sick of printk debugging.  I work on two different PPC
>> > boards.  An 860 and 8260.
>> >
>> > I want to get some feedback on the best kernel debugger to use.  I
>> > have been looking at three.
>> >
>> > 1.  kgdb
>> > 2.  kdb
>> > 3.  UML
>> >

For the 860 you can purchase a hardware debugger from www.denx.de for
50 Euros.  For the 8260 you must buy the more expensive BDI2000, but
that is Freescale's fault.  But the look and feel of BDI2000 is the same as
BDI4GDB, just faster, so you can decide whether it's worth the money for 
you.
When you say 'kgdb' you imply 'gdb' which is the standard GNU-world
debugger.  kgdb is a means for letting a kernel communicate with a PC based
(or equivalent) gdb and is an alternative to a hardware debugger.  Also,
check out ddd, a front end for gdb.

IMHO, these serial debugging ports on PPC are the greatest thing since 
sliced
bread and it would be foolish not to take advantage of them.

Mark C. 

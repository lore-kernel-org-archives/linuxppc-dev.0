Return-Path: <bwaite@irobot.com>
Received: from irobot.com (smtp1.irobot.com [66.238.211.203])
	by ozlabs.org (Postfix) with ESMTP id 6629067B76
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 11 Aug 2006 05:25:55 +1000 (EST)
From: Brian Waite <bwaite@irobot.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Debugging with no serial port
Date: Thu, 10 Aug 2006 15:13:58 -0400
References: <821B2170E9E7F04FA38DF7EC21DE487105FD1342@VCAEXCH01.hq.corp.viasat.com>
In-Reply-To: <821B2170E9E7F04FA38DF7EC21DE487105FD1342@VCAEXCH01.hq.corp.viasat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200608101513.58626.bwaite@irobot.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thursday 10 August 2006 15:00, Martin, Tim wrote:
> >> Second question would be - is there an easier way to accomplish what
> >> I'm trying to do, which is basically emulate a serial port with GDB.
> >
> > Use NetConsole or remotey log it with syslog...
>
> I guess I wasn't clear in the problem statement - this target doesn't
> have a serial port, an ethernet port, or a file system.  So I can't log
> over Ethernet or log by writing to a file.  I'm fairly restricted to
> getting data out of the system using GDB controlling a hardware JTAG
> debugger (think BDI2000).
I don't know GDB internals so I cannot answer the specific question relating 
to synchronous writes via GDB.
But...
How much data are we talking and is there some area of private memory to stash 
the logged data in and use the JTAG adapter to fetch the memory blocks and 
write to a local file for post processing? I've done this in places where I 
am doing kernbel bringup without a serial port. Your other option is use a 
few IO pins (if available) and make a bit banging serial interface with some 
extrnal components. 

Thanks
Brian

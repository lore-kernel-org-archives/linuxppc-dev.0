Message-ID: <3810A961.FF50C5F8@netx4.com>
Date: Fri, 22 Oct 1999 14:13:53 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Grant Carter <gcarter@eng.uct.ac.za>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: MPC823 Serial ports
References: <38107697.9A2576F7@eng.uct.ac.za>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Grant Carter wrote:
> 
> Hi all
> 
> I am trying to get the second serial port (SMC2) up and running. I have
> found that it was removed from arch/ppc/8xx_io/uart.c in the rs_table
> struct. I have added this again and now the kernel (2.2.5) seems to find
> it on bootup.

Yes.  I was using SMC2 on the TDM when I made the update.  You
can enable up to four (because of baud rate generators) serial
ports for uarts.  Pick any that you want.  This will be more
configurable in newer versions of the config scripts I am going
to check into CVS one of these days.

> What else do I need to do to get it working as when I echo something to
> it, I get nothing out of the port.

Make sure you have the device nodes in /dev properly defined.
They should be:
	ttyS0 4,64
	ttyS1 4,65
	ttyS2 4,66
	ttyS3 4,67



	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

Return-Path: <dhlii@comcast.net>
Received: from rwcrmhc12.comcast.net (rwcrmhc14.comcast.net [216.148.227.89])
	by ozlabs.org (Postfix) with ESMTP id CB58A6895F
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  5 Jan 2006 10:08:22 +1100 (EST)
Message-ID: <43BC542F.5040302@comcast.net>
Date: Wed, 04 Jan 2006 18:03:11 -0500
From: "David H. Lynch Jr." <dhlii@comcast.net>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
References: <20051208231947.92EB9353F77@atlas.denx.de>
In-Reply-To: <20051208231947.92EB9353F77@atlas.denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Problems starting /init
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

 I have  a kernel for a new board (Linux 2.6.14.5, Pico E12/Xilinx V4
PPC405) booting to the point of starting /init.

/init appears to be getting loaded correctly - the execve call seems
happy. But I get no output on the console.

I have tried:

	executing
		sys_write(1,"Test",4);

		inside init/main.c immediately before starting /init - works fine.
	starting a "hello World" application written in PPC asm as /init -
works fine. The kernel panics on exit but that is normal, /init is not
supposed to exit.

	starting a c "Hello World" application that uses glibc, fputs, printf,
fwrite, to display a string - again works fine.

	But I can not get busybox to output a thing either run as /init or run
as /bin/sh.

	I have aslo tried /bin/sash - no output.
	I have even cross compiled sash - with all kinds of "I am here"
debugging scattered through main(), If I runn it on a powerbook, I get
what I expect. If I run it as /bin/sh on the e12 I get no output.


	Does anyone even have any ideas what I can look at ?
	

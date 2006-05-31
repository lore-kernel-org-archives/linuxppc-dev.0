Return-Path: <blofeldus@yahoo.com>
Received: from web53511.mail.yahoo.com (web53511.mail.yahoo.com
	[206.190.39.65]) by ozlabs.org (Postfix) with SMTP id 76DF467A64
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  1 Jun 2006 07:49:05 +1000 (EST)
Message-ID: <20060531214224.52756.qmail@web53511.mail.yahoo.com>
Date: Wed, 31 May 2006 14:42:24 -0700 (PDT)
From: roger blofeld <blofeldus@yahoo.com>
Subject: Help with MPC5200 + Bestcomm + Local Plus Bus
To: linuxppc embedded <linuxppc-embedded@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi
 I have a custom board which is essentially an icecube with an FPGA on
the local bus. I have a driver which pulls data from the FPGA in
response to interrupts using memcpy_fromio(). I would like to reduce
the CPU usage.

Has anyone used bestcomm to move data from LPB to memory? Is there an
example anywhere? From the app note AN2604 it looks like writing a
bestcomm task is difficult at best. Perhaps it is possible to re-use
the ethernet rx task for this purpose?

I'm using mainline 2.6.16.18 with Sylvain's patches for
ethernet/bestcomm/ide. (BTW, will that code make it into the mainline
any time soon?)

Thanks in advance for any advice
-roger


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 

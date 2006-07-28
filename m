Return-Path: <paravpandit@yahoo.com>
Received: from web36610.mail.mud.yahoo.com (web36610.mail.mud.yahoo.com
	[209.191.85.27]) by ozlabs.org (Postfix) with SMTP id 41A7A67B55
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 28 Jul 2006 21:28:04 +1000 (EST)
Message-ID: <20060728112803.34466.qmail@web36610.mail.mud.yahoo.com>
Date: Fri, 28 Jul 2006 04:28:02 -0700 (PDT)
From: Parav Pandit <paravpandit@yahoo.com>
Subject: writing CCSR_BAR register for relocation?
To: linuxppc-embedded@ozlabs.org
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

Hi,

I am newbie to MPC8555, PowerPC family and u-boot.
Please guide me.

1. How can I read/write registers from the u-boot
similar to md/mm command? Basically I want to
read/write CCSR_BAR from the u-boot.

2. How can I read/write CCSRBAR register value from my
assembly program?
mfspr.mtspr ??? what is the register name??

3. By changing the default value of 0xFF70:0000 to
0xE000:0000 is sufficient to relocate the 1MB block or
anything else is also required?

4. I look at the u-boot code for tqm85xx, 8555cds, and
8555ads series of boards and it does something with
TLB.
I don't understand why it modifies the TLB registers
whose purpose is only for the performance improvement?
Or we can use the TLB for something else also?

Regards,
Parav Pandit


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 

Return-Path: <runet@innovsys.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Date: Thu, 21 Oct 2004 16:57:56 -0500
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B06DB90@ismail.innsys.innovsys.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: <Linuxppc-embedded@ozlabs.org>
Cc: 
Subject: CPM2 uart early console
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Is there any way of getting an early console output on a kernel on an
8260? (running u-boot as bootloader)
Right now, I don't get any console output until after the full driver is
loaded, and that is way too late, since the kernel is hanging on the PCI
init right now, and the kernel log buffer doesn't have the backtrace of
the Oops.

BTW..
What are the device node numbers for ttyCPM[0..5] ?

Rune Torgersen
System Developer
Innovative Systems LLC
1000 Innovative Drive
Mitchell, SD 57301
Ph: 605-995-6120
www.innovsys.com

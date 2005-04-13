Return-Path: <fabidi@ultsol.com>
Received: from smtpauth09.mail.atl.earthlink.net
	(smtpauth09.mail.atl.earthlink.net [209.86.89.69])
	by ozlabs.org (Postfix) with ESMTP id A608467A67
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Apr 2005 00:00:29 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Date: Wed, 13 Apr 2005 09:37:27 -0400
Message-ID: <81C69D96BDD30640952C7A404004AA25018DB9@ultsol01.tewks.ultsol.local>
From: "Fahd Abidi" <fabidi@ultsol.com>
To: "Kylo Ginsberg" <kylo@veriwave.com>,
	<linuxppc-embedded@ozlabs.org>
Subject: RE: bdi2000 + mpc8560ads, very early breakpoints
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Try the suggestions pointed out in here:

http://www.ultsol.com/faq-P308.htm

This is based off suggestions from another customer. Let me know if this
works for you or not.

Fahd

-----Original Message-----
From: Kylo Ginsberg [mailto:kylo@veriwave.com]=20
Sent: Tuesday, April 12, 2005 3:21 PM
To: linuxppc-embedded@ozlabs.org
Subject: bdi2000 + mpc8560ads, very early breakpoints

I'm running a bdi2000 (with mpc85xx-gdb f/w 1.03) with a mpc8560ads=20
target, and I'm trying to set breakpoints early on in linux startup (in=20
the head_e500.S code that sets up tlb's).   I'm setting the breakpoints=20
from within the bdi telnet interface.

I can:
--succesfully hit a breakpoint set up to any instruction <=3D the =
address=20
of the first 'tlbwe'.
--single step (with the bdi "TI" command) past that 'tlbwe' as far as=20
I've cared to try

I cannot:
--hit a breakpoint once the first 'tlbwe' has executed.  If I attempt to

do so, linux startup doesn't proceed, I lose further communication with=20
the target and the BDI claims "COP Freeze" and I have to reset the
target.

Btw, the 'tlbwe' in question marks invalid the first tlb1 entry setup by

u-boot, which pointed at flash address space.  Code is running out of=20
ram at this point.

I'm probably missing something very basic here.  Any ideas?

Thanks,
Kylo

_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded

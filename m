Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: upgrade advice
Date: Fri, 25 Apr 2003 10:40:27 +0200
Message-ID: <FD6CA6C74666E546981AEBE7F147C5123D0E8A@mx-dk1.dk.vitesse.com>
From: "Holger L. Bille" <hlb@vitesse.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi

On our development platform (ppc405gp + 16 MB flash + 128 MB PC100 SDRAM) I have come
across some nasty Oopses, that are really hard to root cause. As I see it I now have 3
options.

1 - work around the problem
2 - spend the time to track it down
3 - Apply patches to get our kernel uptodate
4 - Start over with a more recent distrib


About 1:
Not _really_ an option since it might come back and bite us later

About 2:
Could take a lot of time. And it could be time wasted, since our kernel is somewhat old
and the bug might be known and fixed. This brings me to the next option.

About 3:
This where I really need some input from all of you. Is this feasible on the MV journeyman
distrib? Is it close enough to the standard kernel from kernel.org to be done with
reasonable effort.

About 4:
We are currently using the free version of MonteVista linux. I think it's called
Journeyman Edition. Starting over with a new distro - either MV or ELDK - and porting our
modifations, will probably require considerable effort.
The straight forward thing to do would be to pay MV to do this upgrade for us. On the
other hand going for the Denx solution would mostly likely leave us more in control while
still providing us with the option of hiring consultants to do the kernel stuff for us.

Please tell me what are your experiences + recommendations in situations like this?
I hope this the appropriate list to ask this sort of question.

Best regards,
_____________________________________

Holger Lindeberg Bille
Software Design Engineer
Vitesse Semiconductor Corporation A/S
Ethernet Products Group
Hoerkaer 16,  DK-2730 Herlev, DENMARK
Direct: +45 4485 5914, Mobile: +45 5190 9110
Phone: +45 4485 5900, Fax: +45 4485 5901
mail: hlb@vitesse.com
web: http://www.vitesse.com
_____________________________________


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

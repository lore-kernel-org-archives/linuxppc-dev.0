Message-ID: <3D6EA039.8000107@lvl7.com>
Date: Thu, 29 Aug 2002 18:29:13 -0400
From: Neil Horman <nhorman@lvl7.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: m8xx_ide_default_irq
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hey all!
	I'm running the M.V. 2.4.17 kernel and I had a question about the 8xx ide over
pcmcia code.  Specifically in m8xx_ide_default_irq there is a check to ensure
that the passed in base value is greater than or equal to MAX_HWIFS.  If its
true, we return zero.  Can anyone tell me why that check is there?  Since base
appears by all rights to be the address of an ide interface (or in this case a
ioremapped pcmcia interface, with a comapct flash attached running in ide mode),
this check will never fail, and If i wanted to return, say the interrupt for the
pcmcia subsystem, I never would.  Any thoughts?
Thanks!
Neil :)

--
/******************************************************************
*Neil Horman
*Software Engineer
*LVL7 Systems
*13000 Weston Pkwy.
*Cary, NC 27513
*(919)-865-2915
*nhorman@lvl7.com
*PGP keyID 0xB5E1020A
*http://www.keyserver.net/en
*******************************************************************/


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

Return-Path: <robers97@yahoo.com>
Received: from web56902.mail.re3.yahoo.com (web56902.mail.re3.yahoo.com
	[66.196.97.91]) by ozlabs.org (Postfix) with SMTP id CC566DDE06
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 24 Jan 2007 16:35:58 +1100 (EST)
Date: Tue, 23 Jan 2007 21:35:56 -0800 (PST)
From: Steven Roberts <robers97@yahoo.com>
Subject: PCMCIA on 860T FADS  - correct approach?
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <332899.90834.qm@web56902.mail.re3.yahoo.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

=0AI am trying to configure a 2.4.25 kernel for an 860TFADS board with PCMC=
IA support.  I set the  kernel flag CONFIG_PCMCIA_M8XX which pulls in drive=
rs/pcmcia/m8xx_pcmcia.c (cvs 1.17).  I'm getting a machine check during err=
ors when the voltage_set() function is called on m8xx_init() when the BSCR1=
 is being set:=0A=0Am8xx_pcmcia: Voltage set 0=0Am8xx_pcmcia: First, turn o=
ff all power.=0Am8xx_pcmcia: BCSR1 &=3D 0xffbeffff=0Am8xx_pcmcia: BCSR1 &=
=3D 0x00300000=0A=0AIn looking at the newsgroups, it seems like support for=
 this might be pulled into module package after 2000 or so.  Before I figur=
e out all the correct register settings, could someone tell me if I should =
continue on this path?  Perhaps there is a more up-to-date file that contai=
n these functions and I should not include the m8xx_pcmcia flag?=0A=0AThank=
s for any guidance!=0A=0A=0A=0A=0A =0A_____________________________________=
_______________________________________________=0ATV dinner still cooling? =
=0ACheck out "Tonight's Picks" on Yahoo! TV.=0Ahttp://tv.yahoo.com/

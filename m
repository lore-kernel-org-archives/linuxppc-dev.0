Return-Path: <clemens.koller@anagramm.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id 0580A2BDF2
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 15 Jan 2005 02:31:17 +1100 (EST)
Received: from [212.227.126.205] (helo=mrelayng.kundenserver.de)
	by moutng.kundenserver.de with esmtp (Exim 3.35 #1)
	id 1CpTPw-0005RE-00
	for linuxppc-embedded@ozlabs.org; Fri, 14 Jan 2005 16:31:16 +0100
Received: from [217.80.228.140] (helo=[192.168.1.10])
	by mrelayng.kundenserver.de with asmtp (Exim 3.35 #1)
	id 1CpTPw-0004YW-00
	for linuxppc-embedded@ozlabs.org; Fri, 14 Jan 2005 16:31:16 +0100
Message-ID: <41E7E64F.2080807@anagramm.de>
Date: Fri, 14 Jan 2005 16:33:35 +0100
From: Clemens Koller <clemens.koller@anagramm.de>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
References: <41E7A410.6060008@anagramm.de>
	<B29E7784-663A-11D9-A3DB-000393DBC2E8@freescale.com>
In-Reply-To: <B29E7784-663A-11D9-A3DB-000393DBC2E8@freescale.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: Re: Kernel 2.6.x to MPC8540/Microsys Board
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:

> I would suggest 2.6.10 if you want an official kernel release.  Is this 
> board generally available to people? 

Yes: www.microsys.de miriac Module: PM854 (and some others)

> Be aware there are some infrastrucal changes I'm working on that moves 
> the 85xx sub-arch support from using OCP to platform_device.  However, 
> these have minor changes on the board files.

I've read your last mails in this list... therefore I am asking. :-)
I just don't want to re-invent the wheel twice. In the pm854 specific
things there are also some OCP updates. (Well, I am still reading lots 
of code... newland for me)
I try to contact the developer Josef Wagner at Microsys who was working
on the 2.4.26-sth.

> I would take a look at how 2.6 is structured for 85xx.  I tried to do a 
> better job and provide more common code for a board port to leverage.  
> So for something like PCI, you should hopefully just have to setup your 
> memory map and IRQ routing.

I am comparing 2.4.26-sth with 2.6.10 now. The changes are manageable as 
far as I got it. Where can I get the current work from you?!

Greets,

Clemens Koller
_______________________________
R&D Imaging Devices
Anagramm GmbH
Rupert-Mayer-Str. 45/1
81379 Muenchen
Germany

http://www.anagramm.de
Phone: +49-89-741518-50
Fax: +49-89-741518-19

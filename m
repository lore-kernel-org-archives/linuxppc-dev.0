Return-Path: <Jogi95@web.de>
Received: from fmmailgate04.web.de (fmmailgate04.web.de [217.72.192.242])
	by ozlabs.org (Postfix) with ESMTP id 68AACDDD0B
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 Jul 2008 23:40:22 +1000 (EST)
Date: Thu, 17 Jul 2008 15:40:20 +0200
Message-Id: <883740264@web.de>
MIME-Version: 1.0
From: Joachim Meyer <Jogi95@web.de>
To: Jens Wirth <jewirth@googlemail.com>
Subject: Re: use xilinx gpio from linux on a ppc405
Content-Type: text/plain; charset=iso-8859-15
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Jens

Thanks for your fast answer.
I have some questions befor I try it out:
1. Can I proof, if my gpio is correctly connected with my design or should I try it to proof it?
2. Is the code you send c? If yes, do I need any specific libaries? Then I crosscompile it, put it on my Board and it should work?
3. In edk I saw This at the 4 LEDs:
Base Adress: 0x40000000
High Adress: 0x4000ffff
How would it be for my case? Something like this:

char *mapped_address = ioremap(0x40000000, 0xffff);
writeb(0xffff, mapped_address); 
iounmap(mapped_address);

I don't understand why the there are so many steps between the base and the high adress. 

Thanks and Greez
Joachim
_____________________________________________________________________
Der WEB.DE SmartSurfer hilft bis zu 70% Ihrer Onlinekosten zu sparen!
http://smartsurfer.web.de/?mc=100071&distributionid=000000000066

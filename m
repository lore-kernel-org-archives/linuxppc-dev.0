Return-Path: <clemens.koller@anagramm.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.189]) by ozlabs.org (Postfix) with ESMTP id 4BEEB2BDF2
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 15 Jan 2005 01:34:19 +1100 (EST)
Received: from [212.227.126.162] (helo=mrelayng.kundenserver.de)
	by moutng.kundenserver.de with esmtp (Exim 3.35 #1)
	id 1CpSWn-00054n-00
	for linuxppc-embedded@ozlabs.org; Fri, 14 Jan 2005 15:34:17 +0100
Received: from [217.80.228.140] (helo=[192.168.1.10])
	by mrelayng.kundenserver.de with asmtp (Exim 3.35 #1)
	id 1CpSWn-0007KO-00
	for linuxppc-embedded@ozlabs.org; Fri, 14 Jan 2005 15:34:17 +0100
Message-ID: <41E7D8F7.4060901@anagramm.de>
Date: Fri, 14 Jan 2005 15:36:39 +0100
From: Clemens Koller <clemens.koller@anagramm.de>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
References: <20050114113126.434C4C108D@atlas.denx.de>
In-Reply-To: <20050114113126.434C4C108D@atlas.denx.de>
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

Wolfgang Denk wrote:

>>Which is the best Kernel source tree to start porting 2.6.x to the pm854 
>>platform? I would prefer to stuck with the official sources. Is that a 
>>good idea?
 >
> Yes.

Thank you, that's what I wanted to hear :-)

>>Is it a good idea to just 'copy' the pm854 platform specific files (PCI 
>>  initialization and some MTD driver options) to the 2.6.10 tree and see
>>how it works?
> 
> Copy from where? from 2.4? No.

Well, I don't know how the platform specific things got moved from 2.4 
to 2.6 in the past (yes I am a newbie). I have a working 
2.4.26-pm854-something with a platform/pm854_defconfig (and some changed 
non-official(?) files for the PCI and MTDs) and I want to get the same 
for 2.6.10+ without changing things at the wrong place.

Best greets,

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

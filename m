Return-Path: <dhlii@dlasystems.com>
Received: from outbound-mail-35.bluehost.com (outbound-mail-35.bluehost.com
	[69.89.18.155]) by ozlabs.org (Postfix) with SMTP id 2B2DEDDDFB
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 27 Nov 2007 08:36:54 +1100 (EST)
Received: from c-76-99-73-82.hsd1.pa.comcast.net ([76.99.73.82]
	helo=hp-dhlii.dlasys.net)
	by host151.hostmonster.com with esmtpa (Exim 4.68)
	(envelope-from <dhlii@dlasystems.com>) id 1IwldN-00067n-UD
	for linuxppc-embedded@ozlabs.org; Mon, 26 Nov 2007 14:36:54 -0700
Message-ID: <474B3C75.1080508@dlasystems.com>
Date: Mon, 26 Nov 2007 16:36:53 -0500
From: "David H. Lynch Jr." <dhlii@dlasystems.com>
MIME-Version: 1.0
To: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: Xilinx devicetrees
References: <47480CF0.7090105@dlasys.net>	<fa686aa40711240912r192aba72o2cbdb798370e7b7c@mail.gmail.com>	<47493D4F.4070605@dlasys.net><fa686aa40711251421q38f53ee3hb2a308cc5f93183f@mail.gmail.com>
	<4749FD5E.7000408@dlasys.net>
	<20071125235855.95B9999804D@mail138-cpk.bigfish.com>
In-Reply-To: <20071125235855.95B9999804D@mail138-cpk.bigfish.com>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Stephen Neuendorffer wrote:
> In any event, why do you do this rather than just run out of the flash (or a ram copy of the flash?)
>   
    This is not literally true, but  the parameters are nearly the same
- pretend we are using NAND flash  and storing executables as elf files.

    We can not run from flash because:
       The code has not been relocated
       the flash is not persistent
    We do load the flash/elf file into DRAM  dealing with elf issues
along the way and then execute it.   
    We can do something similar for devicetrees, actually just passing
Linux the offset from the begining of flash to the devicetree would be
sufficient. Or if finding the devicetree inside the bitsstream can be
accomplished fairly simply, just passing the offset of the bit file.


-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein

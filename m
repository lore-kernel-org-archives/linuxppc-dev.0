Return-Path: <jacmet@sunsite.dk>
Received: from kuuvir01.barco.com (kuu212123311.barco.com [212.123.3.11])
	by ozlabs.org (Postfix) with SMTP id 0012DDDE1D
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 19 Apr 2007 22:44:44 +1000 (EST)
Received: from peko by sleipner.barco.com with local (Exim 4.60)
	(envelope-from <jacmet@sunsite.dk>) id 1HeW00-0000fV-SK
	for linuxppc-embedded@ozlabs.org; Thu, 19 Apr 2007 14:44:32 +0200
From: Peter Korsgaard <peter.korsgaard@barco.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Using Cypress EZ-Host on ML403/5
References: <4623A197.6000104@computing.dundee.ac.uk>
	<528646bc0704160932k2038090al8c0b8e5420422545@mail.gmail.com>
Date: Thu, 19 Apr 2007 14:44:32 +0200
In-Reply-To: <528646bc0704160932k2038090al8c0b8e5420422545@mail.gmail.com>
	(Grant Likely's message of "Mon, 16 Apr 2007 10:32:40 -0600")
Message-ID: <87zm54mt3j.fsf@sleipner.barco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

>>>>> "Grant" == Grant Likely <grant.likely@secretlab.ca> writes:

Hi,

>> Has anyone had the Cypress EZ-Host chip working as a USB host under
>> Linux?  It's the one that comes fitted as standard to ML403 and
>> ML405 boards (probably other Xilinx boards too).  If not, can
>> anyone tell me where I should start?  Any advice at all?  Our own
>> embedded device needs to have USB host support and we are using an
>> ML40x for development so the EZ-Host is the preferred solution as
>> we can prototype it.

Grant> It's on my task list to get working.  I could certainly use
Grant> some help.

I have written a 2.6 USB host driver for the Cypress
EZ-Host/EZ-Otg. It's basically working, but needs a bit more
cleanup. I hope to be able to submit it next week.

-- 
Bye, Peter Korsgaard

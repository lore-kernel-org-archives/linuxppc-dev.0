Return-Path: <dwh@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "sabrina.ovro.caltech.edu",
	Issuer "sabrina.ovro.caltech.edu" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 67E8A67B33
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 11 Feb 2006 06:16:15 +1100 (EST)
Message-ID: <43ECE5DF.8050809@ovro.caltech.edu>
Date: Fri, 10 Feb 2006 11:13:35 -0800
From: David Hawkins <dwh@ovro.caltech.edu>
MIME-Version: 1.0
To: "Travis B. Sawyer" <tsawyer@sandburst.com>, linuxppc-embedded@ozlabs.org
Subject: Re: Yosemite/440EP 'issues' as a PCI target
References: <20060209003459.0ED30352564@atlas.denx.de>	<43EBD715.4020303@ovro.caltech.edu>
	<200602100847.54363.sr@denx.de> <43ECC7CE.1010409@ovro.caltech.edu>
	<43ECCCA2.1070007@sandburst.com>
	<43ECCE7A.4090507@ovro.caltech.edu>
	<43ECD19E.8010604@sandburst.com>
In-Reply-To: <43ECD19E.8010604@sandburst.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Travis,

>>> Ah, the ol' dec 21555, everyone has had to use one in their lifetime...
>>> Not bad, not great...
>>
>> Not great, so any suggestions for whats better?
>>
> Everytone uses them because they're easy and just work. Sometimes you 
> may need to tweak the setup eeprom, but in general they just work.
> We use a pericom 7300 (can't remember and working from home today), that
> is quite nice.  Not an issue with it at all. HW guy just plunked it down 
> and it worked.  They have an eval board to.

The 7300 is a PCI-to-PCI bridge that only operates in transparent
mode, it does not have any I2O capabilities. I used the Pericom
cross-reference guide and they don't have a replacement part
for the 21555, or the PLX6254 or PLX6540. So, thanks for the
suggestion, but the 21555 still has it.

I didn't find any Pericom bridge that was non-transparent.

Dave

Return-Path: <littelld@verizon.net>
Received: from vms173001pub.verizon.net (vms173001pub.verizon.net
	[206.46.173.1]) by ozlabs.org (Postfix) with ESMTP id 10C16DDDEC
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  6 Sep 2008 13:32:53 +1000 (EST)
Received: from [192.168.1.106] ([96.226.142.190]) by vms173001.mailsrvcs.net
	(Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
	with ESMTPA id <0K6R00EM78IQ6R32@vms173001.mailsrvcs.net> for
	linuxppc-embedded@ozlabs.org; Fri, 05 Sep 2008 22:32:51 -0500 (CDT)
Date: Fri, 05 Sep 2008 22:32:50 -0500
From: Dave Littell <littelld@verizon.net>
Subject: Re: direct access to Flash from userland
In-reply-to: <200809051750.13421.arnd@arndb.de>
To: linuxppc-embedded@ozlabs.org
Message-id: <48C1F9E2.2030502@verizon.net>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
References: <0B45E93C5FF65740AEAE690BF3848B7AD38369@rennsmail04.eu.thmulti.com>
	<200809051750.13421.arnd@arndb.de>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Arnd Bergmann wrote:
> On Thursday 04 September 2008, Fillod Stephane wrote:
>>> Is there a way for a userland application to issue non-CFI commands
>>> directly to a Flash device?  (This is a 2.6.18-based kernel on a AMCC
>>> PPC440EPx platform.)
>> I don't know whether there's specific ioctl for such purpose.
>> Have you tried to read the mtd source? You may also hack the mtd
>> layer to add your command. Definitely a question for 
>> http://www.linux-mtd.infradead.org/mail.html
>>
> 
> There is no ioctl command for sending arbitrary requests to the
> flash, but it sounds like something that should be implemented
> in the kernel, in mtdchar, depending on what the command does.
> 
> What are you actually trying to do with those commands?
> 

Hi Arnd,

There are some sector protection options and a user-writable
one-time-programmable section that's larger than the presently
implemented 8-byte area that I need to support.


Thanks,
Dave

Return-Path: <robin.gilks@tait.co.nz>
Received: from gatekeeper.tait.co.nz (unknown [202.37.96.21])
	by ozlabs.org (Postfix) with ESMTP id 5146767A99
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  1 Feb 2005 08:49:24 +1100 (EST)
Received: from gatekeeper.tait.co.nz (merlin.tait.co.nz [127.0.0.1])
	by localhost.tait.co.nz (Postfix) with ESMTP id 68EEC10BAD2
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  1 Feb 2005 10:49:23 +1300 (NZDT)
Received: from sunstrike.tait.co.nz (unknown [172.25.40.92])
	by gatekeeper.tait.co.nz (Postfix) with ESMTP id DE7A410BAD0
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  1 Feb 2005 10:49:22 +1300 (NZDT)
Received: from conversion-daemon.sunstrike.tait.co.nz by sunstrike.tait.co.nz
	(Sun Java System Messaging Server 6.1 (built Apr 28 2004))
	id <0IB700L019ZIYD00@sunstrike.tait.co.nz>
	(original mail from robin.gilks@tait.co.nz) for
	linuxppc-embedded@ozlabs.org; Tue, 01 Feb 2005 10:49:22 +1300 (NZDT)
Date: Tue, 01 Feb 2005 10:49:21 +1300
From: Robin Gilks <robin.gilks@tait.co.nz>
In-reply-to: <41FDD9A3.9040604@intracom.gr>
To: Pantelis Antoniou <panto@intracom.gr>
Message-id: <41FEA7E1.3060204@tait.co.nz>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
References: <41F70114.5040200@tait.co.nz> <41F74169.9050006@intracom.gr>
	<41FD5C91.404@tait.co.nz> <41FDD9A3.9040604@intracom.gr>
Cc: ppc embedded list <linuxppc-embedded@ozlabs.org>
Subject: Re: 8xx bus monitoring
Reply-To: robin.gilks@tait.co.nz
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Pantelis Antoniou wrote:
>>>
>>> You get a machine check exception.
>>>
>>> It's pretty obvious then :)
>>>
>>
>> Using a 2.4.22 based kernel, as far as I can see a machine check 
>> should be trapped (its only allowed to cause a reset in the reboot 
>> code I think). Assuming I got it right and it really is trapped, how 
>> come I always get a reset:-((
>>
>> Any pointers to the code that does setup for causing an exception 
>> (rather than reset) would be appreciated.
>>
> 
> Check the MSR register at the time of the access.
> Is RI set? If not instead of an exception you get a reset...

I don't understand this - the whole point is that an exception occurs 
asynchronously and therefore I don't know where the access it, except of 
course I don't get an exception!!!

Where (insert name of source file in kernel tree) is RI set in MSR (or 
should be set but is missing from the kernel I'm using) so as to ensure 
that an exception occurs and how does the kernel distinguish a bus 
monitor timeout from other causes.

If the kernel (or the MPC8xx) is not capable of this then I guess I'll 
just have to fix the hardware :-((


-- 
Robin Gilks
Senior Design Engineer          Phone: (+64)(3) 357 1569
Tait Electronics                Fax  :  (+64)(3) 359 4632
PO Box 1645 Christchurch        Email : robin.gilks@tait.co.nz
New Zealand

=======================================================================
This email, including any attachments, is only for the intended
addressee.  It is subject to copyright, is confidential and may be
the subject of legal or other privilege, none of which is waived or
lost by reason of this transmission.
If the receiver is not the intended addressee, please accept our
apologies, notify us by return, delete all copies and perform no
other act on the email.
Unfortunately, we cannot warrant that the email has not been
 altered or corrupted during transmission.
=======================================================================

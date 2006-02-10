Return-Path: <dwh@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "sabrina.ovro.caltech.edu",
	Issuer "sabrina.ovro.caltech.edu" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 5B09367B58
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 11 Feb 2006 05:00:51 +1100 (EST)
Received: from [192.100.16.36] (kiwi.ovro.caltech.edu [192.100.16.36])
	by ovro.ovro.caltech.edu (8.13.1/8.13.1) with ESMTP id k1AI0mHV011097
	for <linuxppc-embedded@ozlabs.org>; Fri, 10 Feb 2006 10:00:48 -0800
Message-ID: <43ECD43F.5090809@ovro.caltech.edu>
Date: Fri, 10 Feb 2006 09:58:23 -0800
From: David Hawkins <dwh@ovro.caltech.edu>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Re: Yosemite/440EP 'issues' as a PCI target
References: <20060210173133.964B53525CC@atlas.denx.de>
	<43ECCF7C.9070701@ovro.caltech.edu>
In-Reply-To: <43ECCF7C.9070701@ovro.caltech.edu>
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


Hey Travis,

 >> Not great, so any suggestions for whats better?
 >>
 > Everyone uses them because they're easy and just work. Sometimes
 > you may need to tweak the setup eeprom, but in general they just work.
 > We use a pericom 7300 (can't remember and working from home
 > today), that is quite nice.  Not an issue with it at all. HW
 > guy just plunked it down and it worked.  They have an eval board to.

I was going to take a look around TIs site, I'd forgotten Pericom
makes bridges too, I'll read the data book.

 > ... I've not had a need to use it, my work is 90% PCI
 > (forwarding engine, queueing engine, etc) for 10G ethernet, so
 > FPU stuff is very rare, and not time critical (used for setting
 > up policing/rate limiting etc). Basically, set it and forget it
 > calculations.

I figured that was probably the case - and the reason the majority
of the embedded processors are sans-FPU. I didn't want to use a
TI DSP again, there's just no 'community spirit' like with Linux.

So, I'll take a look at the PowerQUICC that Wolfgang mentioned, and
see if I want to change to that processor, another look at the ColdFire
(I have an MCF5485 eval board), and a look at the bridge data sheets
and see where that leaves me.

Personally, I want to stay with the PowerPC, the developer mailing
list is great!

Thanks,
Dave

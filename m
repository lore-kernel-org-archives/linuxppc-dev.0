Return-Path: <geoffrey.levand@am.sony.com>
Received: from outbound1-haw-R.bigfish.com (outbound-haw.frontbridge.com
	[12.129.219.97])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 4241E688F8
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 21 Dec 2005 08:26:32 +1100 (EST)
Received: from outbound1-haw.bigfish.com (localhost.localdomain [127.0.0.1])
	by outbound1-haw-R.bigfish.com (Postfix) with ESMTP id C7D3768C556
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 20 Dec 2005 20:53:10 +0000 (UTC)
Received: from mail2-fra-R.bigfish.com (unknown [192.168.51.1])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by outbound1-haw.bigfish.com (Postfix) with ESMTP id 687186828FA
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 20 Dec 2005 20:53:10 +0000 (UTC)
Received: from mail2-fra.bigfish.com (localhost.localdomain [127.0.0.1])
	by mail2-fra-R.bigfish.com (Postfix) with ESMTP id 556E34A803D
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 20 Dec 2005 20:52:42 +0000 (UTC)
Received: from mail8.fw-bc.sony.com (mail8.fw-bc.sony.com [160.33.98.75])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by mail2-fra.bigfish.com (Postfix) with ESMTP id 200544A803D
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 20 Dec 2005 20:52:42 +0000 (UTC)
Message-ID: <43A73A90.3060908@am.sony.com>
Date: Mon, 19 Dec 2005 14:56:16 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: David Jander <david.jander@protonic.nl>
References: <821B2170E9E7F04FA38DF7EC21DE4871022BB9A9@VCAEXCH01.hq.corp.viasat.com>
	<200512191039.58149.david.jander@protonic.nl>
In-Reply-To: <200512191039.58149.david.jander@protonic.nl>
Content-Type: text/plain; charset=UTF-8
Cc: "Martin, Tim" <tim.martin@viasat.com>, linuxppc-embedded@ozlabs.org
Subject: Re: POSIX High Resolution Timers in LinuxPPC 2.4
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

David Jander wrote:
> Hi Tim,
> 
> On Friday 16 December 2005 23:34, Martin, Tim wrote:
> 
>>Could someone give me a brief history lesson on POSIX high resolution
>>timers (e.g. timer_create() function) implemented in the Linux kernel on
>>the PowerPC 405 architecture?  Specifically:
>>
>>Confirm they are in the mainline 2.6 kernel now (e.g. kernel.org)?
>>
>>Were they ever a part of the "mainline" 2.4 linuxppc kernel (e.g
>>ppc.bkbits.net)?
>>
>>If no, were they ever available as a patch? The stuff at
>>sourceforge.net/projects/high-res-timers stops at 2.4.20 and looks like it
>>was only ever working for i386, not ppc.
> 
> 
> I asked a related question a while back, and got no answer (yet).
> I did find this though, which you might have overlooked:
> http://prdownloads.sourceforge.net/high-res-timers/ppc-hrt-2.6.10.patch?download
> 
> I am equally puzzled about whether this has made it into mainstream, is about 
> to, or never will. I don't even know if it actually works.
> 

You would do better to inquire on the HRT mailing list:

  http://lists.sourceforge.net/lists/listinfo/high-res-timers-discourse

HRT support (from http://sourceforge.net/projects/high-res-timers/) was
never accepted to mainline.  It works on Ebony (PPC440), but I guess it
is OK on others since it uses the PPC time base.  I recommend you get
the latest from CVS, which is against 2.6.12.  Older versions have
CVS tags.

-Geoff

Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 11E3D67A33
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 15 Mar 2006 05:23:09 +1100 (EST)
To: Randy Smith <rsmith@imagemap.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: rtai for ppc in 2.6 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 14 Mar 2006 11:09:51 EST."
	<4416EACF.2010802@imagemap.com>
Date: Tue, 14 Mar 2006 19:23:07 +0100
Sender: wd@denx.de
Message-Id: <20060314182307.278D63539FF@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <4416EACF.2010802@imagemap.com> you wrote:
> 
> I am working to port an existing Lite5200 application that uses rtai on 
> the 2.4 kernel to a 2.6 kernel.  I have just noticed that support for 
> rtai in 2.6 is limited to the i386 tree.  Is there anyone working on the 
> ppc 2.6 rtai?  In looking at the rthal patch for the i386, it seems 

No, no such woirk is going on. And probably never will. RTAI is  dead
on  anything but x86. Actually it has never been completely ported to
PPC - things like LXRT are simply not portable.

> Alternatively, I could rip out the rtai dependent code and just use the 
> native 2.6 kernel's improvements for near realtime response and see how 
> it goes but that route will take a little time.  I was hoping for a 
> quick recompile and go. :-(  Any advice?

Yes. My advise is: use Xenomai. It works fine both on 2.4 and 2.6 and
is a major leap forward.

> Also,  I have been reading about Adeos and rtai's adoption of this.  

See www.xenomai.org ; then ask remaining  questions  on  the  xenomai
mailing lists.


Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Nothing ever becomes real until it is experienced.       - John Keats

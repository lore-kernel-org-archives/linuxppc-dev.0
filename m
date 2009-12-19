Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 19EA0B6F19
	for <linuxppc-dev@ozlabs.org>; Sun, 20 Dec 2009 05:56:59 +1100 (EST)
To: Hunter Cobbs <hunter.cobbs@gmail.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: DWC_OTG Issues
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <1261190115.14590.5.camel@mobiLinux>
References: <1261176637-23912-1-git-send-email-ptyser@xes-inc.com>
	<1261190115.14590.5.camel@mobiLinux>
Date: Sat, 19 Dec 2009 19:56:57 +0100
Message-Id: <20091219185657.5FF29E85072@gemini.denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dear Hunter Cobbs,

In message <1261190115.14590.5.camel@mobiLinux> you wrote:
> Hello list.  I've run into a rather odd problem.  I seem to have a
> problem with full-speed isochronous transfers across a USB2.0 Hub.  I
> believe this was observed before with the general EHCI drivers in Linux.

Which exazct kernel / driver cversions are you talking about?

> In the latest branch of the kernel, the EHCI driver has some "Enhanced
> Transaction Translation" scheduling.  This would be great for me to use
> as it seems to directly address the issues I've seen.  However, I'm not
> really sure on how to proceed because the DWC_OTG driver is not GPL code

Oops? if that wa the case you could not use (and distribute) this code
in a Linux context at all.

> while the EHCI code I'd like to use is.  Therefore, I don't believe that
> I can port the Enhanced Transaction Translation routine into the DWC_OTG
> driver without violating both the GPL and Synopsis's own driver.

What makes you think so?

The Synopsis dwc_otg driver license does not seem to be  in  conflict
to  the  GPL,  if  you  ask  me (but then, I am not a layer). When we
worked on this, we were assured that the use of this driver source in
the context of GPLed software like the Linux kernel (or  U-Boot)  was
not considered an issue by Synopsis.

> Does anyone have a suggestion on how to proceed?

We have been doing some work on the DWC drivers in the past, fixing a
number of issues. [We never  attempted  to  psuh  any  of  this  into
mainline  as  the  Synopsis  drivers  are  -  in  our  opinion  - not
avcceptable for mainline but require more  or  less  a  rewrite  from
scratch. But you can find all this stuff in our linux-2.6-denx repo.]

I recommend you give a try to our latest stable branch.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
What is research but a blind date with knowledge?      -- Will Harvey

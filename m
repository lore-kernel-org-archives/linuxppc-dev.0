Return-Path: <wd@denx.de>
Received: from mailout11.sul.t-online.com (mailout11.sul.t-online.com
	[194.25.134.85]) by ozlabs.org (Postfix) with ESMTP id 6533667B25
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  9 Jun 2005 23:55:21 +1000 (EST)
To: Sylvain Munaut <tnt@246tNt.com>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 09 Jun 2005 13:32:07 +0200."
	<42A828B7.4030305@246tNt.com>
Date: Thu, 09 Jun 2005 15:55:04 +0200
Sender: wd@denx.de
Message-Id: <20050609135509.AD5C2C1512@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: MPC52xx: sysfs failure on adding new device driver 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <42A828B7.4030305@246tNt.com> Sylvain Munaut wrote:
> 
> Don't think so. Your patch applies to the 2.4 while Grant problem is 
> specific to the way the different functions of PSCs are handled to work 
> the 2.6 ppc_sys model.
> 
> btw, if not yet integrated you should send your patch to Wolfang, he's 
> the one maintaining that tree.

I'm subscribed here, too :-)

I've seen the patch, but did not decide yet what to do with it.  Many
drivers  don't  support  devfs  anyway, and in my opinion devfs makes
little sense in embedded systems anyway. Not to mention that it  will
officially  be removed from the kernel tree in less than 4 weeks from
now (see Documentation/feature-removal-schedule.txt).

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Man is the best computer we can put aboard a spacecraft ...  and  the
only one that can be mass produced with unskilled labor.
                                                 -- Wernher von Braun

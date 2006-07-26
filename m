Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 2DB3067B52
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 27 Jul 2006 07:57:56 +1000 (EST)
To: Lee Revell <rlrevell@joe-job.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: Serial issue 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 26 Jul 2006 17:45:23 EDT."
	<1153950324.2927.6.camel@mindpipe>
Date: Wed, 26 Jul 2006 23:57:54 +0200
Sender: wd@denx.de
Message-Id: <20060726215754.46FAE35260B@atlas.denx.de>
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

In message <1153950324.2927.6.camel@mindpipe> you wrote:
> I'm trying to connect to a Yosemite 440 PPC board using the serial
> console.  I've tried everything in every Linux Serial FAQ and HOWTO but
> no matter what, I can receive but I cannot transmit.

Did you disable hardware flow control in your communication program?

Which communication program do you use, btw? I recommend C-kermit;
for details see also
http://www.denx.de/wiki/view/DULG/SystemSetup#Section_4.3.?stickboard=yosemite

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
How many seconds are there in a year? If I tell you there are 3.155 x
10^7, you won't even try to remember it. On the other hand, who could
forget that, to within half a percent, pi seconds is a nanocentury.
                                                - Tom Duff, Bell Labs

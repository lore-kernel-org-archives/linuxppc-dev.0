Return-Path: <wd@denx.de>
Received: from mailout08.sul.t-online.com (mailout08.sul.t-online.com
	[194.25.134.20]) by ozlabs.org (Postfix) with ESMTP id A59052BF16
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  8 Jan 2005 09:30:33 +1100 (EST)
To: Federico Lucifredi <flucifredi@acm.org>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 07 Jan 2005 16:13:45 EST."
	<41DEFB89.5060404@acm.org>
Date: Fri, 07 Jan 2005 23:30:07 +0100
Sender: wd@denx.de
Message-Id: <20050107223012.8C3A6C14E3@atlas.denx.de>
Cc: "Linux-ppc \[mailing list\]" <linuxppc-embedded@ozlabs.org>
Subject: Re: Frame Buffer and Y Cb Cr 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <41DEFB89.5060404@acm.org> you wrote:
> 
>     My trouble is: Linux sends me R G B and the hardware expects Y Cb 
> Cr. As things work through a memory-mapped file, I am at a loss for an 
> "intelligent" way to intercept and convert these values.

Have a look at the arch/ppc/8xx_io/viedo* files in our old  linux-2.4
tree  on the CVS server - this driver is for the video contoller on a
MPC823 wich needs YCbCr.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Sometimes a feeling is all we humans have to go on.
	-- Kirk, "A Taste of Armageddon", stardate 3193.9

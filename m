Return-Path: <wd@denx.de>
Received: from mailout05.sul.t-online.com (mailout05.sul.t-online.com
	[194.25.134.82]) by ozlabs.org (Postfix) with ESMTP id 993A32BC0F
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 26 Oct 2004 05:20:04 +1000 (EST)
To: grave <grave@ipno.in2p3.fr>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 25 Oct 2004 10:51:08 -0000."
	<1098701468l.31592l.0l@ipnnarval>
Date: Mon, 25 Oct 2004 20:12:31 +0200
Sender: wd@denx.de
Message-Id: <20041025181236.4096EC1430@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: uboot and ppc405 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <1098701468l.31592l.0l@ipnnarval> you wrote:
> 
> We re starting a disign with xilinx chip Virtex II pro and I wonder the =20
> typical size of an uboot binary. This is for our electronician disigner =20
> in order to dimension the prom and so on...

Depending on your configuration (selected features) U-Boot  typically
needs 100...240 kB of flash memory. If you reseve 256 kB in flash you
should have no problems.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
"More software projects have gone awry for lack of calendar time than
for all other causes combined."
                         - Fred Brooks, Jr., _The Mythical Man Month_

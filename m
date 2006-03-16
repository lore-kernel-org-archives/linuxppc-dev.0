Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 0F437679E2
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 17 Mar 2006 07:01:33 +1100 (EST)
To: achim.machura@berghof.com
From: Wolfgang Denk <wd@denx.de>
Subject: Re: AW: kernel support for the MPC5200b 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 16 Mar 2006 09:48:11 +0100."
	<002401c648d6$5b808b70$34f1ff0a@beint.local>
Date: Thu, 16 Mar 2006 21:01:30 +0100
Sender: wd@denx.de
Message-Id: <20060316200130.25FEE353B16@atlas.denx.de>
Cc: "Linuxppc-Embedded \(E-Mail\)" <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <002401c648d6$5b808b70$34f1ff0a@beint.local> you wrote:
> 
> > I want to run the Linux kernel on a device based on the Freescale
> MPC5200b, based on the MPC603e series G2_LE core.
> 
> Look at www.denx.de there is support for 2.4 and 2.6

Actually we support only 2.4 on the MPC5200. The current 2.6 port has
a couple  of  known  issues,  and  I  cannot  recommend  it  for  any
commercial project yet.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
An Ada exception is when a routine gets in trouble and says
'Beam me up, Scotty'.

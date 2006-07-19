Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 1B62367B73
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 20 Jul 2006 04:37:42 +1000 (EST)
To: Laurent Pinchart <laurent.pinchart@tbox.biz>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: MPC8260 SCC UART hardware flow control 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 19 Jul 2006 17:18:00 +0200."
	<200607191718.00328.laurent.pinchart@tbox.biz>
Date: Wed, 19 Jul 2006 20:37:40 +0200
Sender: wd@denx.de
Message-Id: <20060719183740.22636352681@atlas.denx.de>
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

In message <200607191718.00328.laurent.pinchart@tbox.biz> you wrote:
> 
> I was wondering if anyone had implemented hardware flow control support in the 
> cpm_uart driver. If not, I would appreciate pointers regarding how to do so.

You can probably take our 2.4 kernel code as a starting point. But be
aware of the inherent restrictions of the CPM, see
http://www.denx.de/wiki/view/DULG/UseSCCUARTWithHardwareHandshake

[In the end, you might want to configure  the  handshake  signals  as
GPIO lines and controll these manually. But then you will have to ask
yourself why you are using a CPM...]

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
The average woman would rather have beauty than brains,  because  the
average man can see better than he can think.

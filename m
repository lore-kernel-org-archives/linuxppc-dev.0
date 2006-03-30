Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 52669679E0
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 30 Mar 2006 11:34:21 +1100 (EST)
To: Sylvain Munaut <tnt@246tNt.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: Kernel for MPC Lite 5200 will not compile 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 30 Mar 2006 01:02:00 +0200."
	<442B11E8.7020107@246tNt.com>
Date: Thu, 30 Mar 2006 02:34:19 +0200
Sender: wd@denx.de
Message-Id: <20060330003419.3FF71353A37@atlas.denx.de>
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

In message <442B11E8.7020107@246tNt.com> you wrote:
>
> It is ?

I think so.

> I don't know about the 2.6-denx, but the stock 2.6.15 should work just fine.
> What's wrong with it ? (except it misses some drivers ... it should compile
> and boot just fine)

Isn't the current reengineered implementation of  the  BestComm  code
based  on  an very old Freescale version, which has known limitations
and problems?

Or has there any action resulted  out  of  the  discussion  with  the
Freescale engineers, and I have missed it?

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
In accord with UNIX philosophy, Perl gives you enough  rope  to  hang
yourself.              - L. Wall & R. L. Schwartz, _Programming Perl_

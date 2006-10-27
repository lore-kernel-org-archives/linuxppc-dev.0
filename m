Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 7734767DA0
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 28 Oct 2006 07:19:45 +1000 (EST)
To: John W <jmwoo2@yahoo.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: Building ELDK 3.0/3.1 from SRPMS 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 27 Oct 2006 11:21:14 PDT."
	<20061027182114.24662.qmail@web50315.mail.yahoo.com>
Date: Fri, 27 Oct 2006 23:19:42 +0200
Sender: wd@denx.de
Message-Id: <20061027211942.B7FEB3535FD@atlas.denx.de>
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

Dear John,

in message <20061027182114.24662.qmail@web50315.mail.yahoo.com> you wrote:
> 
> I having trouble rebuilding ELDK 3.0 & ELDK 3.1 from
> the source RPMS.  I have spent a great deal of time on
> this, and I have a feeling that maybe I=92m just not
> doing something correctly (setting up the build
> environment, retrieving source/specs from CVS..
> etc..).  My build machine is Red Hat 9.0 without any
> updates (Kernel 2.4.20-8, the Shrike release).

This will not work; to build ELDK 3.x from scratch you need a  RH-7.3
box *with* all updates installed.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
e-credibility: the non-guaranteeable likelihood that  the  electronic
data you're seeing is genuine rather than somebody's made-up crap.
- Karl Lehenbauer

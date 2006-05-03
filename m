Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 81CC067B1E
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  4 May 2006 09:00:20 +1000 (EST)
To: Jean-Marie Teuler <jean-marie.teuler@lcp.u-psud.fr>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: Impossible to open the root console with 2.6.15 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 03 May 2006 15:36:08 +0200."
	<1146663369.2448.25.camel@khnoum.lcp.u-psud.fr>
Date: Thu, 04 May 2006 01:00:14 +0200
Sender: wd@denx.de
Message-Id: <20060503230014.BA748353BE7@atlas.denx.de>
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

In message <1146663369.2448.25.camel@khnoum.lcp.u-psud.fr> you wrote:
> 
> I am trying to use ELDK 4.0 on my TQM860L board.
> 
> I have compiled the included 2.6.15 kernel with reasonable options, but
> when I try to boot it, I do not get the prompt after the message
> "Uncompressing Kernel Image ... OK"

We do not support Linux 2.6 kernels for MPC8xx systems yet.  For  the
TQM860L please continue to use ELDK 3.1.1 as shipping with the board.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Committee, n.:  A group of men who individually can do nothing but as
a group decide that nothing can be done.                 - Fred Allen

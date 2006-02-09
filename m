Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 5D6B667A2E
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  9 Feb 2006 20:07:45 +1100 (EST)
To: "S. Egbert" <s.egbert@sbcglobal.net>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: eldk bug?how to fix 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 08 Feb 2006 23:35:14 PST."
	<43EAF0B2.2070902@sbcglobal.net>
Date: Thu, 09 Feb 2006 10:07:43 +0100
Sender: wd@denx.de
Message-Id: <20060209090743.4ABD5353B88@atlas.denx.de>
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

In message <43EAF0B2.2070902@sbcglobal.net> you wrote:
>
>     # export CROSS_COMPILE=ppc_8xx-  (DENK gcc 3.3.3)
> or
>     # export CROSS_COMPILE=powerpc-linux-  (GNU gcc)

Ummm.... the compiler included with the ELDK is GNU gcc, too.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
An expert is a person who avoids the small errors while  sweeping  on
to the grand fallacy.

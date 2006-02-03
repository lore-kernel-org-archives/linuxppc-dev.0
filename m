Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 002FC6891D
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  4 Feb 2006 00:43:59 +1100 (EST)
To: Marc.Bodmer@securiton.ch
From: Wolfgang Denk <wd@denx.de>
Subject: Re: How to cross-build OpenSSL shared library 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 03 Feb 2006 10:45:44 +0100."
	<5DDC68DD3569BB4D92D660326A9C095301728952@stnzolex1.securiton.int>
Date: Fri, 03 Feb 2006 14:43:55 +0100
Sender: wd@denx.de
Message-Id: <20060203134355.BF5493535EA@atlas.denx.de>
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

In message <5DDC68DD3569BB4D92D660326A9C095301728952@stnzolex1.securiton.int> you wrote:
> 
> I am using ELDK (3.1.1) and there is a built OpenSSL as shared library
> available.
> Does anybody know about how they managed to build this shared library?

The DULG describes in detail how to rebuild all ELDK  RPMs  from  the
sources.  Just  download  and  install  the  Source RPM and check the
commands in the spec file.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Perl already has an IDE.  It's called Unix.
                      -- Tom Christiansen in 375bd509@cs.colorado.edu

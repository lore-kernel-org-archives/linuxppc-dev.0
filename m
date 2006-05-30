Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 9FFFB67B1F
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 31 May 2006 06:43:44 +1000 (EST)
To: "Behre, Frederik - LT" <Behre.Frederik@litef.de>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: MPC8270 on Microsys PM827 Kernel 2.6 Oops: kernel access of bad
	area, sig: 11 [#1]
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 30 May 2006 14:46:21 +0200."
	<CC692F5386B0AA47A62B7484A7CA2B6D02B52CB0@frmx1.litef.de>
Date: Tue, 30 May 2006 22:43:42 +0200
Sender: wd@denx.de
Message-Id: <20060530204342.82BBC3525D9@atlas.denx.de>
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

In message <CC692F5386B0AA47A62B7484A7CA2B6D02B52CB0@frmx1.litef.de> you wrote:
> 
> I compile my kernel with 
> pm82x_deconfig and PCI disabled.
...
> MPC8260 Reset Status: External Soft, External Hard

Why do you use pm82x_deconfig with a MPC8260  processor?  You  should
use pm826_deconfig instead.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
That's the thing about people who think  they  hate  computers.  What
they really hate is lousy programmers.
- Larry Niven and Jerry Pournelle in "Oath of Fealty"

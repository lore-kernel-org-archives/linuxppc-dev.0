Return-Path: <wd@denx.de>
Received: from mailout07.sul.t-online.com (mailout07.sul.t-online.com
	[194.25.134.83]) by ozlabs.org (Postfix) with ESMTP id E6F2968198
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 24 Aug 2005 03:20:44 +1000 (EST)
To: "JohnsonCheng" <johnsoncheng@qnap.com.tw>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 23 Aug 2005 13:26:46 +0800."
	<20050823053053.67D1A42AFE@denx.de>
Date: Tue, 23 Aug 2005 10:59:20 +0200
Sender: wd@denx.de
Message-Id: <20050823085920.D1BD4353D18@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Linux Kernel MTD question 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <20050823053053.67D1A42AFE@denx.de> you wrote:
> When I want to turn on MTD with TQM8XXL, I can't find it in kernel 2.6.12.3.
> I use "MTD\Mapping drivers for chip access\CFI Flash device in physical
> memory map", it seems only one partition can be used.

There is no working support for TQM8xxL in the 2.6 kernel tree yet.

Please use the 2.4 kernel from our CVS server instead.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
"And they told us, what they wanted... Was a sound  that  could  kill
some-one, from a distance."                               - Kate Bush

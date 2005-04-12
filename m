Return-Path: <wd@denx.de>
Received: from mailout11.sul.t-online.com (mailout11.sul.t-online.com
	[194.25.134.85]) by ozlabs.org (Postfix) with ESMTP id 07C7767AC5
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 13 Apr 2005 07:13:55 +1000 (EST)
To: "Eric N. Johnson (ACD)" <ejohnson@acdstar.com>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 12 Apr 2005 14:38:20 CDT."
	<6.2.1.2.1.20050412143653.02ae7720@mail.int.acdstar.com>
Date: Tue, 12 Apr 2005 23:13:37 +0200
Sender: wd@denx.de
Message-Id: <20050412211342.B7C92C108D@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: (no subject) 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <6.2.1.2.1.20050412143653.02ae7720@mail.int.acdstar.com> you wrote:
> 
> The kernel included in the DENX ELDK v3.1.1 has two drivers:
>    i2s_ring.c and i2s.c.

i2s.c is not really a driver, but a (very OLD) test  version  of  one
used  to  demonstrate  certain  BestComm  related problems. Don't try
using it as a real driver ;-)


Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
People are always a lot more complicated than you  think.  It's  very
important to remember that.             - Terry Pratchett, _Truckers_

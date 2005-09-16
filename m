Return-Path: <wd@denx.de>
Received: from mailout08.sul.t-online.com (mailout08.sul.t-online.com
	[194.25.134.20]) by ozlabs.org (Postfix) with ESMTP id C7CE56829F
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 16 Sep 2005 21:23:56 +1000 (EST)
To: "JohnsonCheng" <JohnsonCheng@qnap.com.tw>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 16 Sep 2005 15:00:31 +0800."
	<20050916070358.781D2422AF@denx.de>
Date: Fri, 16 Sep 2005 13:23:23 +0200
Sender: wd@denx.de
Message-Id: <20050916112324.0528D352B7B@atlas.denx.de>
Cc: 'linux-ppc-embedded' <linuxppc-embedded@ozlabs.org>
Subject: Re: How to use kerberos in ELDK 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <20050916070358.781D2422AF@denx.de> you wrote:
> 
> Maybe I meet the big trouble.
> I find no powerpc-linux-rpm in my build machine, only have
> powerpc-linux-gcc, powerpc-linux-ar .....
> What should I do?

You should really READ the documentation. It says, and I  explicitely
quoted this in my previous posting:

> You must use "${CROSS_COMPILE}rpm" instead.

So instead of trying powerpc-linux-rpm which indeed  does  not  exist
you  should  run  ppc_8xx-rpm  or whichever other architecture you're
using (alternatively ppc-rpm would work, but this is undocumented and
not recommended).

Please RTFM!


Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
"...and the fully armed nuclear warheads, are, of  course,  merely  a
courtesy detail."

Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net
 [IPv6:2001:a60:0:32:0:1:25:1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 8ECB6B6FBD
 for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2012 06:14:03 +1000 (EST)
To: Bob Cochran <ppc@mindchasers.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: MSR loses DE bit in 3.3, BDI2000 cant handle breakpoints?
MIME-Version: 1.0
Content-type: text/plain; charset=UTF-8
In-reply-to: <4FC511C1.4050007@mindchasers.com>
References: <OF00FC5182.FED0E75C-ONC1257A0D.003AA532-C1257A0D.0041F687@transmode.se>
 <4FC511C1.4050007@mindchasers.com>
Date: Tue, 29 May 2012 22:13:56 +0200
Message-Id: <20120529201356.3133F2073AD@gemini.denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dear Bob,

In message <4FC511C1.4050007@mindchasers.com> you wrote:
>
> I debug using Freescale CodeWarrior and a USB tap, which also rely on 
> MSR[DE] being set.  I develop from the mainline & have a patch set that 
> I just recently re-tweaked to support kernel debugging.
> 
> If you want, I'll send you my set of patches for the kernel.  They might 
> be useful (not sure since I don't use BDI).

Please rather submit as a patch on the mailing list.

Thanks.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
egrep patterns are full regular expressions; it uses a fast  determi-
nistic algorithm that sometimes needs exponential space.
- unix manuals

Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id B34D6DE288
	for <linuxppc-dev@ozlabs.org>; Sat,  7 Jun 2008 00:33:50 +1000 (EST)
To: Kumar Gala <galak@kernel.crashing.org>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: [PATCH v2 1/4] [POWERPC] 85xx: add board support for the TQM8548
	modules
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 06 Jun 2008 08:59:45 CDT."
	<A261F367-1C5F-4197-92FD-07E7AD1D21FC@kernel.crashing.org>
Date: Fri, 06 Jun 2008 16:33:47 +0200
Sender: wd@denx.de
Message-Id: <20080606143347.B35CC247FE@gemini.denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In message <A261F367-1C5F-4197-92FD-07E7AD1D21FC@kernel.crashing.org> you wrote:
> 
> > As I see it, I have to define DTS_FLAGS manually
> >
> >  $ export DTS_FLAGS="-R4 -S0x3000"
> >  $ make ARCH=powerpc tqm8548.dtb
> >
> > to get a working blob. Is that the intended behavior?
> 
> this is normal.  Andy Fleming has posted a patch to u-boot to help  
> improve the situation.  I'm not sure if WD has picked it up for 1.3.4  
> yet.

I will. But wouldn't it make sense to allow at least for  some  level
of  compatibility with older versions of U-Boot? Adding these options
as default would probably not hurt?

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Anarchy may not be the best form of government, but it's better  than
no government at all.

Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id EB961DDDFF
	for <linuxppc-dev@ozlabs.org>; Sun,  5 Apr 2009 22:03:53 +1000 (EST)
To: Yigal Goldberger <yigal_gold@yahoo.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: booting Kernel 2.6.24.2 with u-boot 1.1.2
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <673522.16603.qm@web38902.mail.mud.yahoo.com>
References: <673522.16603.qm@web38902.mail.mud.yahoo.com>
Date: Sun, 05 Apr 2009 14:03:50 +0200
Message-Id: <20090405120350.5041F83797DC@gemini.denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Dear Yigal Goldberger,

In message <673522.16603.qm@web38902.mail.mud.yahoo.com> you wrote:
> 
> I'm trying to upgrade my powerpc system from 2.6.14.7 to 2.6.24.2 .
> I'm confused regarding the need to use a Flattened Device Tree, and not sure whether and how I should use it .Does u-boot 1.1.2 support it ?
> (I migrated from ARCH=ppc to ARCH=powerpc) .

U-Boot 1.1.2 nows  absolutely  nothing  about  device  trees  yet.  I
recommend  to  update  to  current  code  - both for U-Boot and Linux
(Linux 2.6.24.2 is really old, too).

You probably can run a recent kernel on that old U-Boot version using
a cuImage, but it would be better to use current code.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
How can you tell when sour cream goes bad?

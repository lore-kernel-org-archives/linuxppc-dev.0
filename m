Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id BD44CDDF3D
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Sep 2008 06:49:26 +1000 (EST)
To: Sean MacLennan <smaclennan@pikatech.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: arch/powerpc/boot/.gitignore questions
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <20080910164046.4813753b@wally.pikatech.com>
References: <48C81ED5.1030701@oracle.com>
	<20080910164046.4813753b@wally.pikatech.com>
Date: Wed, 10 Sep 2008 22:49:23 +0200
Sender: wd@denx.de
Message-Id: <20080910204923.D06D7248A6@gemini.denx.de>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, linuxppc-dev@ozlabs.org,
	paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Dear Sean MacLennan,

In message <20080910164046.4813753b@wally.pikatech.com> you wrote:
> 
> I believe if the dts is built into u-boot, the dtc is not built.

This is never the case. The device tree is considered to be  part  of
and provided to the boot loader by the kernel.


Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Mr. Cole's Axiom:
        The sum of the intelligence on the planet is a constant;
        the population is growing.

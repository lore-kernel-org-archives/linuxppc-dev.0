Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id A2B3FB6F01
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 30 Jun 2010 08:02:40 +1000 (EST)
To: Stevan Ignjatovic <stevan@iritel.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: ftp login problem using wu-ftpd
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <1277820991.4257.18.camel@stevan>
References: <1277820991.4257.18.camel@stevan>
Date: Wed, 30 Jun 2010 00:02:37 +0200
Message-Id: <20100629220237.30A75152442@gemini.denx.de>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dear Stevan Ignjatovic,

In message <1277820991.4257.18.camel@stevan> you wrote:
> 
> I ported Linux-2.6.30-rc8 on my custom mpc885 board. The filesystem I am
> using is jffs2 which I created from
> eldk-4.2/ppc_8xx/images/ramdisk_image.gz. Linux boots fine and I can
> telnet to the board but I cannot ftp:
...
> Here ftp connection hangs. Do I have to create another user (beside
> root) in order to make ftp connection? Earlier, when I was using 2.4
> linux I didn't have problems with ftp connection as root.

check your kernel configuration. You might be missing options like
CONFIG_UNIX98_PTYS or CONFIG_LEGACY_PTYS or similar.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Every program has at least one bug and can be shortened by  at  least
one instruction - from which, by induction, one can deduce that every
program can be reduced to one instruction which doesn't work.

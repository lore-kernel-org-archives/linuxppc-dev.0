Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id 6FE3ADE61B
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jul 2008 08:33:08 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: "Rune Torgersen" <runet@innovsys.com>
Subject: Re: 82xx performance
Date: Thu, 17 Jul 2008 00:32:36 +0200
References: <DCEAAC0833DD314AB0B58112AD99B93B04AE61BC@ismail.innsys.innovsys.com>
	<200807162345.26395.arnd@arndb.de>
	<DCEAAC0833DD314AB0B58112AD99B93B04B3499C@ismail.innsys.innovsys.com>
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B04B3499C@ismail.innsys.innovsys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200807170032.36564.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, Milton Miller <miltonm@bga.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 16 July 2008, Rune Torgersen wrote:
> I did run oprofile, but I could not figure out how to get it to show me
> where in the kernel it was spending time. It showed that a lot of time
> was spent in vmlinux, but not anything specific. I probably just don't
> know how to set up or run oprofile correctly.

Maybe you passed no vmlinux, or only a stripped one?
Oprofile needs to have a vmlinux file to extract the symbol
information from.

If you can't get it to work, readprofile(1) is a much simpler
tool, both in what it can do and what it requires you to do.

	Arnd <><

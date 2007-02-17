Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 302B5DDDFF
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 18 Feb 2007 09:12:38 +1100 (EST)
To: oparz@compuserve.de
From: Wolfgang Denk <wd@denx.de>
Subject: Re: gdb/gdbserver TQM885 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Sat, 17 Feb 2007 20:56:44 +0100."
	<3efc373ef4e6.3ef4e63efc37@compuserve.de>
Date: Sat, 17 Feb 2007 23:12:36 +0100
Sender: wd@denx.de
Message-Id: <20070217221236.6628535265F@atlas.denx.de>
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

In message <3efc373ef4e6.3ef4e63efc37@compuserve.de> you wrote:
>
> I have a problem on debugging my target board TQM885 (ELDK, Linux
> 2.4.25) with gdb/gdbserver . My Testprogram is a simple helloworld. The
> program itself is running as expected, but its not possible to debug.
...
> Host running gdb:
> oparz@linux:~/autoconf_tests/hello_GNU-0.1> gdb ./hello_GNU
> GNU gdb 6.3

That's wrong. You cannot use a native x86 GDB to debug a PowerPC
system.

> Remote sent bad register number 40: 3000ef14;
> Packet: 'T0501:7ffffed0;40:3000ef14;'

Here it's telling you that it has problems to understand the other
architecture.

> Any help is very appreciated

Use the ppc_8xx-gdb that comes with the ELDK instead. And make sure to
read the DULG, especially the hints about setting
solib-absolute-prefix

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH, HRB 165235 Munich, CEO: Wolfgang Denk
Office:  Kirchenstr. 5,       D-82194 Groebenzell,            Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
There's no sense in being precise  when  you  don't  even  know  what
you're talking about.                             -- John von Neumann

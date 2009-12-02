Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id E5A5FB7BBD
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  3 Dec 2009 07:09:44 +1100 (EST)
To: Allan Wang <aiyuanwang@yahoo.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: EP440XS board boot problem(Note:similart to Sequoia)
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <880531.39933.qm@web52905.mail.re2.yahoo.com>
References: <401793.31718.qm@web52903.mail.re2.yahoo.com>
	<20091201231022.AB72CE6D391@gemini.denx.de>
	<880531.39933.qm@web52905.mail.re2.yahoo.com>
Date: Wed, 02 Dec 2009 21:09:42 +0100
Message-Id: <20091202200942.506BF4C025@gemini.denx.de>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dear Allan Wang,

In message <880531.39933.qm@web52905.mail.re2.yahoo.com> you wrote:
> 
> Thank you for your help. My answer to your questions are between the lines.
>  Attached is the dts file I use.

No, there is no attachment.

> Which exact version of U-Boot are you running on this board?
> 
> => version
> 
> U-Boot 1.1.6 (Oct 25 2009 - 13:26:41)

Um... why don't you update? This is really historic stuff...

> What is your exact boot command?
> 
> I tftp the cuImage to address 0x200000 and bootm to boot.
> 
> Which boot arguments do you pass to the kernel?
> 
> bootargs=$(bootargs) console=ttyS0,$(baudrate)

Please provide complete answers, and not only the snippets that seem
important to you. For example, what is the "$(bootargs)" above?

Maybe you provide a full boot log right from reset/power on, including
the output of the "printenv" command on your system.

> The u-boot sets it to 115.2k. the dts file is set to 115.2k. Here is the bo
> ot parameter:
> baudrate=115200

Arghhh.. Please provide the actual output fdrom your system, not just
some parts you copy.

> What does your device tree look like?
> 
> I attached my dts file.

No, it's missing.

> > 2. It pakics when mounting the root file system(NFS):
> > (gdb) bt
> > #0 panic (fmt=0xc0290e94 "VFS: Unable to mount root fs on %s")
> 
> So what is the "%s" argument here? Which sort of root file system are
> you trying to mount - NFS, ramdisk, UBIFS, ... ?
> 
> I try to use NFS for the root file system.

Then you can also run a packet sniffer (like wireshark) to see if any
NFS requests actually get sent to the targte, resp. where it stops).

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Romulan women are not like Vulcan females. We are  not  dedicated  to
pure logic and the sterility of non-emotion.
	-- Romulan Commander, "The Enterprise Incident",
	   stardate 5027.3

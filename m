Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 4165767C54
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  7 Nov 2006 10:38:54 +1100 (EST)
To: mvw@nurfuerspam.de
From: Wolfgang Denk <wd@denx.de>
Subject: Re: Kernel 2.6.18 and JFFS2 Filesystem problem 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 06 Nov 2006 14:30:41 +0100."
	<20061106133041.94740@gmx.net>
Date: Tue, 07 Nov 2006 00:38:48 +0100
Sender: wd@denx.de
Message-Id: <20061106233848.07F00353A5F@atlas.denx.de>
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

In message <20061106133041.94740@gmx.net> you wrote:
> 
> i dont know what my mistake.

We don';t know either - not from such a vague message.

> What files do i need for a filesystem?

See for example
http://www.denx.de/wiki/view/DULG/RootFileSystemDesignAndBuilding

> Is it correct to build the filesystem with these parameters?
> --> mkfs.jffs2 -r dir -o jffs2 -e 0x40000 -p

This might be OK, but we don't know your hardware.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
"How is this place run - is it an anarchy?"
"No, I wouldn't say so; it is not that well organised..."

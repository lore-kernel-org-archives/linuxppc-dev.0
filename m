Return-Path: <wd@denx.de>
Received: from mailout09.sul.t-online.com (mailout09.sul.t-online.com
	[194.25.134.84]) by ozlabs.org (Postfix) with ESMTP id A34A9682C0
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 20 Sep 2005 01:33:21 +1000 (EST)
To: "Peter Fercher" <peter.fercher@scs.ch>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 19 Sep 2005 11:16:08 +0200."
	<002e01c5bcfa$c500d860$dbe5fed4@scsad.scs.ch>
Date: Mon, 19 Sep 2005 17:33:07 +0200
Sender: wd@denx.de
Message-Id: <20050919153307.6EED8352682@atlas.denx.de>
Cc: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: kernel 2.6.12.2,
	octobus ppc405EP: GUNZIP ERROR - must RESET board to recover
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <002e01c5bcfa$c500d860$dbe5fed4@scsad.scs.ch> you wrote:
> 
...
> TFTP from server 192.168.1.1; our IP address is 192.168.1.2
> Filename 'uImage-2.6.12.2'.
> Load address: 0x100000
...
>    Image Type:   PowerPC Linux Kernel Image (gzip compressed)
>    Data Size:    919184 Bytes = 897.6 kB
...
> GUNZIP ERROR - must RESET board to recover.

Your load address is much too low for a kernel that big.

> any hints ?

Yes. RTFM. RTFAQ. See especially
http://www.denx.de/twiki/bin/view/DULG/LinuxUncompressingError

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
The important thing about being a leader is not being right or wrong,
but being *certain*.                    - Terry Pratchett, _Truckers_

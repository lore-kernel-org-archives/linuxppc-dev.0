Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id D3E24DDEF3
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  5 Aug 2008 09:00:00 +1000 (EST)
To: Fabien Oriede <fabien.oriede@yahoo.fr>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: suffisant space for U-Boot,
	Linux and an initrd image ? (4MB SDRAM)
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 04 Aug 2008 12:54:00 -0000."
	<789365.58211.qm@web27401.mail.ukl.yahoo.com>
Date: Tue, 05 Aug 2008 00:59:57 +0200
Sender: wd@denx.de
Message-Id: <20080804225958.0827524848@gemini.denx.de>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <789365.58211.qm@web27401.mail.ukl.yahoo.com> you wrote:
>
> I would like to know if this is possible to port U-Boot, Linux and an initrd image on a board with 4MB of SDRAM ?

In Theory it may be possible, but just for very tiny demo
applications. Probably not for a useful device.

> When Linux try to boot, there is this line on the terminal :
> "Memory : 2036k available (1036k kernel code, 256k data, 80k init, 0k highmem)"
> So I have 2036k memory available for my initrd image but I don't know if this is suffisant.

Note that a ramdisk is NOT an efficient way to use memory. See fro
example http://www.denx.de/wiki/view/DULG/RootFileSystemSelection
which shows that for example a cramfs image is not only faster to boot
but also needs less RAM.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Keep your head and your heart going in the right  direction  and  you
will not have to worry about your feet.

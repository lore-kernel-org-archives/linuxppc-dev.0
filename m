Message-Id: <200002092058.VAA24849@denx.local.net>
To: Sebastien Articlaux <sebastien_articlaux@yahoo.com>
cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Converting vmlinux.initrd to S-RECORD
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 09 Feb 2000 06:59:05 PST."
             <20000209145905.11737.qmail@web207.mail.yahoo.com>
Date: Wed, 09 Feb 2000 21:58:12 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <20000209145905.11737.qmail@web207.mail.yahoo.com> you write:
>
> I've just read a message posted by Dan in november.
> He said that he would post in ppc.kernel.org a prog
> to convert file into S-Records.
>
> He wrote:
> The program just strips the 64K ELF header and
> converts the rest of the file into S-Records.  You can

No special tools needed. You have everything you need in your
toolbox:

	# Strip ELF header
	dd if=zImage of=image bs=64k skip=1
	# Convert to S-records
	objcopy -I binary -O srec image image.srec

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Heavier than air flying machines are impossible.
                    -- Lord Kelvin, President, Royal Society, c. 1895

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

To: samble@xopnetworks.com
Cc: Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Kernel boot 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 10 Feb 2003 16:44:53 CST."
             <200302101644.53246.samble@xopnetworks.com>
Date: Tue, 11 Feb 2003 00:36:28 +0100
Message-Id: <20030210233633.562CAC6090@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <200302101644.53246.samble@xopnetworks.com> you wrote:
>
> I am using ELDK-2.0 to create a bootable kernel image for PPC8xx. I have
> PPCBoot on my target and I want to download the kernel from the host to the
> target using TFTP boot. I have verified that I can transfer the image via
> TFTP boot. I am creating the initrd image using the following sequence of
> commands.

There is basicly zero relevance to Linux so this is off topic on this
list. You should ask this on the U-Boot-Users mailing list instead.

> 1. make config
> 2. make dep
> 3. make clean

OK so far.

> 4. make zImage.initrd

Wrong. Please see the README for instructions how to  build  a  Linux
image for use with U-Boot / PPCBoot.

> 5. Compress the "zvmlinux.initrd" executable using "gzip"

Twice wrong.

> 6. Execute mkimage command to prepare it for "ppcboot"

Completely bogus.

> responds. Can one of you please point to where I may be going wrong?

Please read the available documentation.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
No question is too silly to ask. Of course, some  questions  are  too
silly to to answer...  - L. Wall & R. L. Schwartz, _Programming Perl_

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

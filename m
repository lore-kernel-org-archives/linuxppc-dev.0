To: Kent Borg <kentborg@borg.org>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Large initrd and arch/ppc/boot/simple Question 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 01 Jul 2003 16:29:44 EDT."
             <20030701162944.E20876@borg.org>
Date: Tue, 01 Jul 2003 22:38:17 +0200
Message-Id: <20030701203822.DB949C592A@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Kent,

in message <20030701162944.E20876@borg.org> you wrote:
>
> We are booting our kernel via the arch/ppc/boot/simple mechanism to
> package up our kernel and initrd.  It seems to work, until we get too
> big.  What is big?  Roughly 8 MB for our one big uncompressed userland
> program, plus the kernel, bash, busybox, and various userland
> utilities.
>
> Can initrd's get that large and still work?  Is the simple boot code
> sensible with these sizes?  (I notice that the "avail ram" message
> that gets printed is just hard coded number...)

I don't know  about  the  "simple  boot  code".  With  U-Boot,  we're
successfully  using  ramdisk  images which uncompress into 128 MB and
bigger filesystems. [And no, please don't ask me who needs that  many
stuff in a ramdisk, nor if there is not any better way to do this.]

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
A rolling stone gathers momentum.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

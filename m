Message-ID: <3AF1A818.DE019F5B@mvista.com>
Date: Thu, 03 May 2001 11:48:56 -0700
From: Matthew Locke <mlocke@mvista.com>
MIME-Version: 1.0
To: David Blythe <blythe@routefree.com>
Cc: Steve Hein <ssh@sgi.com>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: mkcramfs changes to switch endianness
References: <3AF07046.3827B997@sgi.com> <3AF09E93.80A5B92B@routefree.com> <3AF0C16C.95A3CE80@sgi.com> <3AF1A44C.75BA4186@routefree.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


David Blythe wrote:
>
> Steve Hein wrote:
>
> > Just out of curiousity, where do you get the source for the transmeta
> > changes (their Midora Linux, I assume....).  I went looking at their
> > web site, and the FTP location they pointed to contained a
> > midora-1.0.0-beta1*.tar.gz file that was only 36K.....where's the real
> > thing?

that file is just the build structure/files.  once you install that you
need to download the rest from the apps dir on the ftp site.  start at
http://midori.sourceforge.net.

>
> We used this, as a starting point (or one of the other references to
> this patch, i just did a google search to find it again).
>
> http://lwn.net/2001/0118/a/cramfs.php3

That is the patch include with midori.  If i remember correctly, it is
included in the kernel mlz. mlz is the midori packaging method,
basically a tar gz file.

>
> I was hoping that it was all on sourceforge, but I guess not.  We should
> finish integrating the endianness changes against this patch pretty
> soon.  Maybe if someone else knows if there is a more up to date version
> around they could let us know.


it is all there on sourceforge, just need to dig a little:)

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

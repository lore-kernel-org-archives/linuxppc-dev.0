Message-ID: <3AF1A44C.75BA4186@routefree.com>
Date: Thu, 03 May 2001 11:32:44 -0700
From: David Blythe <blythe@routefree.com>
MIME-Version: 1.0
To: Steve Hein <ssh@sgi.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: mkcramfs changes to switch endianness
References: <3AF07046.3827B997@sgi.com> <3AF09E93.80A5B92B@routefree.com> <3AF0C16C.95A3CE80@sgi.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Steve Hein wrote:

> Just out of curiousity, where do you get the source for the transmeta
> changes (their Midora Linux, I assume....).  I went looking at their
> web site, and the FTP location they pointed to contained a
> midora-1.0.0-beta1*.tar.gz file that was only 36K.....where's the real
> thing?

We used this, as a starting point (or one of the other references to
this patch, i just did a google search to find it again).

http://lwn.net/2001/0118/a/cramfs.php3

I was hoping that it was all on sourceforge, but I guess not.  We should
finish integrating the endianness changes against this patch pretty
soon.  Maybe if someone else knows if there is a more up to date version
around they could let us know.
	david

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

Message-ID: <20040319173859.61444.qmail@web21113.mail.yahoo.com>
Date: Fri, 19 Mar 2004 09:38:59 -0800 (PST)
From: Lou Rickard <lou_rickard@yahoo.com>
Subject: Re: coffboot?
To: linuxppc-embedded@lists.linuxppc.org
Cc: dan@embeddededge.com
In-Reply-To: <405B09D7.2010307@embeddededge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Yeah, the Bright Star Engineering IP-Engine.

When I build the kernel from the bse development kit,
which has the 2.2 kernel, I see that a zImage file
(well, zImage is a sym. link to another file called
zvmlinux) gets built in the boot directory, and so
does zImage.gz in the coffboot directory.

The version in the coffboot directory works (when
built into the ramdisk image) works, the other one
(using the real file, not the symbolic link) doesn't.

When I build the kernel from my 2.4 directory, I end
up with a zImage.gz in the boot/images directory, but
it doesn't work.

I'm guessing there's something I've got to do to
convert the zImage.gz in my 2.4 boot/images directory
to coffboot format, but I don't know what that is, and
can't see how they do it in the bse dev kit.

~lr

--- Dan Malek <dan@embeddededge.com> wrote:
> You mean the Bright Star Engineering IP-Engine?  Or
> is
> this something else with the same name?


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

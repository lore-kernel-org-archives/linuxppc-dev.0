Date: Wed, 19 May 2004 14:19:29 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Brian Hawley <bhawley@luminex.com>
Cc: Wolfgang Denk <wd@denx.de>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: Ebony Board, PPC440GP and NFS panics
Message-ID: <20040519211929.GB13351@gate.ebshome.net>
References: <4.2.2.20040519123513.05074da0@bhawley.mailhost.luminex.com> <4.2.2.20040519101456.0509d340@bhawley.mailhost.luminex.com> <4.2.2.20040519123513.05074da0@bhawley.mailhost.luminex.com> <4.2.2.20040519132218.050b0df0@bhawley.mailhost.luminex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4.2.2.20040519132218.050b0df0@bhawley.mailhost.luminex.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, May 19, 2004 at 01:24:21PM -0700, Brian Hawley wrote:
> Actually, I had no intention of trying to port ebony to u-boot.  I just
> wanted
> to get something to work.
>
> Unfortunately, we've had no luck getting it to boot with the default ibm
> bootloader either.

>From your previous e-mails I got an impression that booting with OpenBIOS was
OK.

Actually, a lot of people succefully boot Ebony using stock IBM boot loader (me
included)

Please, post boot log for the _default_ Ebony configuration (using IBM bootlader
_not_ u-boot and build with ebony_defconfig), maybe we can help you.

Eugene.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

Message-ID: <000e01c10884$e4201e60$0401a8c0@trex>
From: "Jeff Rugen" <jprugen@earthlink.net>
To: "Tom Rini" <trini@kernel.crashing.org>
Cc: <linuxppc-dev@lists.linuxppc.org>
References: <000701c10782$96a31e60$0401a8c0@trex> <20010708120006.D825@opus.bloom.county>
Subject: Re: RTC and SCSI for PowerStack/2.4.6 Kernel
Date: Mon, 9 Jul 2001 07:38:58 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> That looks like an OK version of util-linux.  Try compiling CONFIG_RTC_PPC
in
> and not CONFIG_RTC.

That fixed /sbin/hwclock from hanging, thanks.

>
> > Second, I am getting SCSI timeouts when running 2.4.6.  I don't know
enough
> > about SCSI, but the log to the console is the following:
>
> Consistant?  I saw this once when booting off the HD but not the next
time.
> Then I went back to NFS rooted.

I've booted 2.4.6 successfully 4 times so far -- 2 times it crashed with
SCSI timeouts, and 2 times it hung for unknown reasons (with no oops output
or anything).  The second time it might have been framebuffer or network
related (I'd installed clgenfb, changed video modes, and then did 'dir' in
an ftp session to a site with a long directory listing twice -- the second
time it hung).

Did anything change in regards to oops output on crashes since 2.2.x?  I'm
not suprised that the kernel would crash/hang without producing any, but I
thought I'd ask to make sure.

> > Which leads me to believe that I at least have the correct SCSI driver
build
> > (NCR53C8XX, as the revision of 0x2 is less than the 16 that
Configure.help
> > seems to indicate).  Should I instead be using the 53c7,8xx driver?  Or
the
> > sym53c8xx?
>
> sym53c8xx will tell you unsupported chip.  I don't know if 53c7,8xx will
work
> but give it a shot, please. :)

53c7,8xx compiled after fixing two lines, but didn't work.  I emailed the
(old) driver supporter with the information (some of the output indicated to
email him, so I did).  I did try with the 10MHz support, and plan to try it
without, but haven't had the opportunity yet.

Jeff Rugen


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

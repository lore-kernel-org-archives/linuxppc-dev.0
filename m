To: Dan Kegel <dank@kegel.com>
Cc: Brian Padalino <bpadalino@perigee.com>, zjzhou@newrocktech.com,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: how to use busybox to make a ramdisk? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 29 Aug 2003 08:27:33 PDT."
             <3F4F70E5.7070202@kegel.com>
Date: Fri, 29 Aug 2003 20:55:43 +0200
Message-Id: <20030829185548.38032C59E4@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3F4F70E5.7070202@kegel.com> you wrote:
>
> Handy.  I imagine the patches are in the ELDK SRPM for busybox.
> Where can I find that?  I poked around on the eldk site but

There is very little interest in SRPMs (actually you're the first  to
ask  :-) The easiest way to access the patches is from our CVS server
(modules eldk_build and eldk_tarballs):

build/cross_rpms/genext2fs/SOURCES/genext2fs-1.3-eldk.patch
build/cross_rpms/genext2fs/SOURCES/genext2fs_perms.patch
build/cross_rpms/genext2fs/SOURCES/genext2fs_symlink.patch
build/cross_rpms/genext2fs/SOURCES/genext2fs_1.3-4.patch
build/cross_rpms/genext2fs/SOURCES/genext2fs_1.3-4_fifo.patch
build/cross_rpms/genext2fs/SPECS/genext2fs.spec
tarballs/genext2fs_1.3-2.diff
tarballs/genext2fs_1.3.orig.tar.gz


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
It is not best to swap horses while crossing the river.
- Abraham Lincoln

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

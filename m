Message-ID: <6B546A602AD2D211BFF00008C7A42889041D6CBE@hrtades2.atea.be>
From: Goddeeris Frederic <Frederic.Goddeeris@siemens.atea.be>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: FS on flash (initrd, JFFS, ...)
Date: Fri, 16 Nov 2001 13:29:57 +0100
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

Could somebody give me some advise on what filesystems to use on my embedded
Linux platform?

This is my current setup that I have working now: I have the compressed
image of the kernel (+/- 0.5 MB) and a separate initrd image (+/- 1.1 MB)
that contains all needed files to boot and work (using BusyBox and TinyLog
in). I use PPCBoot. Then I have JFFS mounted on a MTD partition for
state-information and small log-files. I have a different initrd-image
because PPCBoot supports it. I need to be able to upgrade the applications
and/or the kernel remotely.

After I have this working, I need to decide how to organize everything for
the final platform. I have multiple questions:

1. When applications are started from the initrd, is it executed in place or
is it loaded again in RAM?

2. Can Linux boot from a JFFS (or any other like CRAMFS) or is a Randisk the
only option?

3. JFFS blocks while performing garbage collection. I suppose it is only the
applications/threads that are working with the files on the JFFS that are
blocked or does this garbage collection take a lot of CPU power so that also
other processes/threads are affected?

4. Any other FS than OFFS that I need to consider for storing state-info and
logfiles?

5. JFFS is stable?

6. Is JFFS2 fit for use in a product yet?

  Thanks a lot!
  Frederic


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

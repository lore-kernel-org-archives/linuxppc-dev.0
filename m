Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3F4F6819.1090002@kegel.com>
Date: Fri, 29 Aug 2003 07:50:01 -0700
From: Dan Kegel <dank@kegel.com>
MIME-Version: 1.0
To: Brian Padalino <bpadalino@perigee.com>
Cc: zjzhou@newrocktech.com, linuxppc-embedded@lists.linuxppc.org
Subject: Re: how to use busybox to make a ramdisk?
References: <DGEEIPOFGGPOACEFBGGCEEAECBAA.bpadalino@perigee.com>
In-Reply-To: <DGEEIPOFGGPOACEFBGGCEEAECBAA.bpadalino@perigee.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Brian Padalino wrote:
> ... there is also a good tutorial on how to create ramdisk images.
>
> http://www.linux.org/docs/ldp/howto/Bootdisk-HOWTO/buildroot.html
>
> The only thing that I do differently is that I use a loopback device like
> so:
>   mount -t ext2 filename /mnt/image -o loop
> This stops mount from complaining to me and I like that.

I highly recommend using genext2fs instead of a loopback mount;
that way you don't need to be root at all when making the image.

Stock genext2fs doesn't handle ramdisks bigger than 8MB, but
there are patches that fix this, and I've been using them happily
for about nine months.  (Maybe they're in the mainline now; not sure.)
- Dan

--
Dan Kegel
http://www.kegel.com
http://counter.li.org/cgi-bin/runscript/display-person.cgi?user=78045


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

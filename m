To: "Linh Dang" <linhd@nortelnetworks.com>
Cc: "Embedded Linux PPC list" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: list of 2.6-related migration issues for embedded programmers? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 20 Jul 2004 07:29:55 EDT."
             <wn5vfgi9arw.fsf@linhd-2.ca.nortel.com>
Date: Tue, 20 Jul 2004 15:42:16 +0200
Message-Id: <20040720134221.93224C109F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <wn5vfgi9arw.fsf@linhd-2.ca.nortel.com> you wrote:
>
> But you don't have to. What ever you can do with the good-old initrd
> image you can do with the new initramfs (really cpio archive)
> image. The main difference is the creation: genext2fs vs cpio.

How do I populate a  initramfs  with  custom  device  nodes?  Without
having root permission, I mean.

And how can I tell a Linux kernel where to find  the  initramfs  data
when they are not linked together?

> I just happen to use zImage.initrd (where ramdisk.image.gz is a cpio
> archive) in our project because it's the most appropriate for our
> situation.

That's OK. Other projects may have different requirements, though.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
You cannot propel yourself forward by patting yourself on the back.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

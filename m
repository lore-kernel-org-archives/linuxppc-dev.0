Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Date: Mon, 19 Jul 2004 13:51:57 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Linh Dang <linhd@nortelnetworks.com>
Cc: Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: list of 2.6-related migration issues for embedded programmers?
In-Reply-To: <wn5k6wzgaxs.fsf@linhd-2.ca.nortel.com>
Message-ID: <Pine.LNX.4.60.0407191350320.23725@dell.enoriver.com>
References: <Pine.LNX.4.60.0407190807450.9101@dell.enoriver.com>
 <wn5k6wzgaxs.fsf@linhd-2.ca.nortel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, 19 Jul 2004, Linh Dang wrote:

> On 19 Jul 2004, rpjday@mindspring.com wrote:

>> - initramfs:  currently, i'm still using a zImage.initrd-based
>> image, and all i know about initramfs is that it's checked for at
>> boot time.  should i care about it?  at some point, probably, i'm
>> sure.
>
> initramfs is convenient. you don't need root access nor special tools
> to create the root-fs. it very easy when you want to
> version-controlled you root-fs.

ah, that would be convenient since, as it is, i'm using a hacked
version of "genext2fs" that allows me to create the initial root fs as
a regular user.  i *definitely* have to look into initramfs, then.

rday

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

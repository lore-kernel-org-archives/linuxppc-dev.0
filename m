Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <20685-04823@sneakemail.com>
Date: Wed, 07 Jul 2004 15:08:06 -0700
From: "Stephen Williams" <612dlag102@sneakemail.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: rpm for embedded system
References: <21704-45627@sneakemail.com> <40EC4D3E.5090405@bluewin.ch> <1138-00007@sneakemail.com> <40EC682F.5090004@bluewin.ch>
In-Reply-To: <40EC682F.5090004@bluewin.ch>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Wolfgang Grandegger wolfgang.grandegger-at-bluewin.ch |PPC Linux
Embedded| wrote:

>>Almost. That is instructions for remaking the ELDK packages
>>from the src.rpms. But I want to take the existing binary
>>rpms and install them on my owh root. This does *not* work:
>>
>>   ppc_4xx-rpm --root=/mnt/flash foo.ppc.rpm
>>
>>I want to do something like that with the packages, so that
>>I can install individual existing ppc.rpm packages from the
>>ELDK disk onyl by flash card.
>
>
> Hm, have a look to the ELDK CDROM, especially check the ".list" files in
> /mnt/cdrom/etc. They actually define the packages to be installed. You
> might copy parts of the tree to disk and tailor the list files according
> to your needs. Then you should be able to install the RPM packages with
> the "install" utility as usual. Nevertheless, a root file system built
> this way is very large, too large for most embedded systems.

Indeed, I really only want 3 or 4 rpms (glibc, e2fsprogs, maybe
a few others) and a few rpms of my own.

It would be ideal to be able to do something like:

    rpm --root=/mnt/flash --initdb
    rpm --root=/mnt/flash -ivh glibc-common-X.ppc.rpm
    rpm --root=/mnt/flash -ivh e2fsprogs-X.ppc.rpm
    rpm --root=/mnt/flash -ivh my-jse-initscripts-X.ppc.rpm

and so on. (As an aside, I may be wanting to allow for
running rpm on the target device itself to update in the
field. Getting fancy, eh?)

--
Steve Williams                "The woods are lovely, dark and deep.
steve at XXXXXXXXXX           But I have promises to keep,
http://www.XXXXXXXXXX         and lines to code before I sleep,
http://www.picturel.com       And lines to code before I sleep."


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

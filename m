Date: Wed, 7 Jul 2004 19:33:46 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Stephen Williams <612dlag102@sneakemail.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: rpm for embedded system
In-Reply-To: <20685-04823@sneakemail.com>
Message-ID: <Pine.LNX.4.60.0407071931460.4395@localhost.localdomain>
References: <21704-45627@sneakemail.com> <40EC4D3E.5090405@bluewin.ch>
 <1138-00007@sneakemail.com> <40EC682F.5090004@bluewin.ch> <20685-04823@sneakemail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, 7 Jul 2004, Stephen Williams wrote:

> Indeed, I really only want 3 or 4 rpms (glibc, e2fsprogs, maybe
> a few others) and a few rpms of my own.
>
> It would be ideal to be able to do something like:
>
>   rpm --root=/mnt/flash --initdb
>   rpm --root=/mnt/flash -ivh glibc-common-X.ppc.rpm
>   rpm --root=/mnt/flash -ivh e2fsprogs-X.ppc.rpm
>   rpm --root=/mnt/flash -ivh my-jse-initscripts-X.ppc.rpm

that's a lot of unnecessary overhead for an embedded system.  if i
want to add an extra program or two, i just grab the binary from the
ELDK distribution.

if it's a package that's not part of ELDK, i download the src rpm from
yellow dog and use ELDK to cross-compile it, then repeat step 1.  rpm
really is overkill for an embedded system.

rday

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

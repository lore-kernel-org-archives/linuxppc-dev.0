Date: Thu, 26 Jul 2001 20:44:59 -0400
From: Armando Di Cianno <diciaa@rpi.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: aty128fb.c missing from rync'd benh sources...
Message-ID: <20010726204459.E19851@garmonbozia.productivitynet.com>
References: <20010726200759.A19851@garmonbozia.productivitynet.com> <20010726200901.C8790@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
In-Reply-To: <20010726200901.C8790@localhost.localdomain>; from eblanton@cs.ohiou.edu on Thu, Jul 26, 2001 at 20:09:01 -0400
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On 2001.07.26 20:09 Ethan Blanton wrote:
> Armando Di Cianno spake unto us the following wisdom:
> > I did an rsync to penguinppc.org::linux-2.4-benh at approx 7/26/01 8 PM
> > EST.
>
> I just rsync'd (8:07PM EST) and it's there.

I realize that this is not the rsync support forums, but trying to get my
TiBook happy again before I leave the high-bandwidth comfort of work, as
many times as I rsync from this source, aty128fb.c does not download.

'mkdir linux-2.4-benh'
'rsync -avz penguinppc.org::linux-2.4-benh . > asdf'
pertinent parts of 'cat asdf':

drivers/video/Config.in
drivers/video/Makefile
drivers/video/S3triofb.c
drivers/video/acornfb.c
drivers/video/acornfb.h
drivers/video/amifb.c
drivers/video/atafb.c
drivers/video/aty.h
drivers/video/aty128.h
drivers/video/atyfb.c
drivers/video/bwtwofb.c
drivers/video/cgfourteenfb.c

aty128fb.c is not found among these files, nor is it in
linux/drivers/video.

I'm stumped; if you're getting the file, then I wish I knew what I was
doing wrong.

Thanks for the help,

__armando di cianno
diciaa@rpi.edu

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

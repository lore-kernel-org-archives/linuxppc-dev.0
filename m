Message-ID: <20011115225047.20820.qmail@kunk.jriver.com>
Subject: Re: E15 Carolina Frame Buffer Driver for 2.4
In-Reply-To: <3BF411A7.4000500@amberdata.demon.co.uk> "from David Monro at Nov
 15, 2001 07:04:07 pm"
To: David Monro <davidm@amberdata.demon.co.uk>
Date: Thu, 15 Nov 2001 16:50:47 -0600 (CST)
From: Robert E Brose II <bob@kunk.jriver.com>
Cc: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


User David Monro says:
> Robert E Brose II wrote:
>
> > One caution:
> >
> [..]
> >
> > A big difference between the ibm_e15 fb driver running on 2.4 as opposed
> > to 2.2 is that this code that tries to get the frame buffer base address
> > succeeds in 2.4 but failed (and was hacked to a "default address") in
> > 2.2.
>
>
> There's a really good reason why 2.4 kernels don't need the hack which
> maps it to the default; 2.4 kernels will assign PCI BARs which weren't
> set up by the firmware. This code should be removed completely in the
> 2.4 version.

Makes sense to me. It APPEARS the crashing problems I was having
were with the 2.4.15-pre4 kernel. I'm running a kernel.org 2.4.14 kernel
with only the ext3 patch and the addition of the e15 driver and
it works fine so far...

I was thinking of hacking the mmap stuff into it to give the illusion
of acceleration. That's probably as far as I can take it. I'm sure it
would be nice to merge it with the S3 code, whether in the 2.4 kernel
trio  code or elsewhere however that's likely more that I can budget
time for now... If you change the driver more perhaps you can put it
back up on your carolina page?

Regards,
Bob
--
Robert E. Brose II    N0QBJ
http://www.jriver.com/~bob/
bob@kunk.jriver.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

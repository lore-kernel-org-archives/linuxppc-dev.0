From: kd@flaga.is
To: linuxppc-embedded@lists.linuxppc.org
Message-ID: <002567F2.003A679A.00@notes.flaga.is>
Date: Mon, 20 Sep 1999 10:37:55 +0000
Subject: Re: Problems with initrd on linux-2.3.18
Mime-Version: 1.0
Content-type: multipart/mixed;
	Boundary="0__=kDsd9jj9lJE8fdSqcwlHremHPbUrjMstegwpLYUm8dlsd2JV8v2efIiq"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


--0__=kDsd9jj9lJE8fdSqcwlHremHPbUrjMstegwpLYUm8dlsd2JV8v2efIiq
Content-type: text/plain; charset=iso-8859-1
Content-Disposition: inline

Scott,

This link was posted to the list a few months ago:

ftp://ftp.signum.se/pub/alex

You might also want to search the List archives for postings on
flashdrivers.

I have the mail somewhere stored. If you want I can dig through my archives
and
forward it to you.

Any way I have used this work to put a small ext2 file system in AMD flash
chip and
boot from it.

I had to change the code a litle bit because my flash chip was 16 bit wide
but the one that
Alexander used was 8 bit wide. I sent my changes to Alexander and they
might be somewhere on
his ftp site. Both me and Alexander are using AMD flash chips, but getting
any CFI compliant
flash should not be hard.

Hope this helps,

K.D.

P.S. Using this driver to write new kernels  or fadsroms to the board is
much faster than
using BDM style wiggler. But of course  you have to use the wiggler if you
write
wrong things to you flash 8-).

Writing becomes as simple as dd if=linuximg of=/dev/flash
maybe with appropriate offsets in the form of ibs=<offset into elf image>
obs=<offset into flash>
where linuximg is on an NFS mounted volume.

Pretty neat! 8-)







Brendan Simon <bsimon@ctam.com.au> on 09/20/99 12:41:37 AM

Please respond to bsimon@ctam.com.au

To:
cc:   linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org> (bcc: Kári
      Davíðsson/Flaga hf/IS)
Subject:  Re: Problems with initrd on linux-2.3.18



--0__=kDsd9jj9lJE8fdSqcwlHremHPbUrjMstegwpLYUm8dlsd2JV8v2efIiq
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline



Scott Wood wrote:

> On a somewhat related sidenote, is there any work being done to access
> FLASH from within Linux, either as a file or a filesystem (or anything)?
> It would be *very* useful to read/store machine-specific configuration
data
> IP address, etc) and/or update the kernel/initrd boot image remotely.
> I hear uC/Linux has a FLASHFS for certain Motorola ColdFire CPU boards.

I don't know the specifics but maybe "romfs" is what you are looking for ?
There are some docs in the linux documentation directory.

Brendan Simon.






--0__=kDsd9jj9lJE8fdSqcwlHremHPbUrjMstegwpLYUm8dlsd2JV8v2efIiq--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

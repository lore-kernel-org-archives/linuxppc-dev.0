Message-ID: <20040323212719.41649.qmail@web21105.mail.yahoo.com>
Date: Tue, 23 Mar 2004 13:27:19 -0800 (PST)
From: Lou Rickard <lou_rickard@yahoo.com>
Subject: Re: coffboot?
To: dan@embeddededge.com
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <405B4037.6090206@embeddededge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I tried, this, but was not successful, and am probably
just not understanding what you're telling me.

I tried loading the zImage file directly into ram
(load zImage 200000), and started after the ELF header
(at 210000), but it failed.

Were you intending that I modify the bootlo.bin file
to point deeper into the zImage to bypass the ELF
header?  Or something different?

I then tried using objcopy, but that didn't work
either, and I'm not really sure what it was supposed
to do, so probably I did it wrong.  'objcopy -O binary
zImage zImage.bin' generates a zImage.bin file that
is, or seems, way too small.  The zImage file is
almost 500KB, the output file is about 21KB.  So, I'm
doing something wrong, and I'm don't have a strong
feel for what the objcopy was supposed to do (I read
the man page, but still didn't get it).

Thanks,

~lr

--- Dan Malek <dan@embeddededge.com> wrote:
> You can do one of two things.  Load the zImage.elf
> as
> a binary to some address (say 400000) and start at
> the
> code past the ELF header (g 410000).
>
> Second, you can 'objcopy -O binary zImage.elf
> zImage.bin',
> then load the zImage.bin (say 400000), then jump to
> the
> address where it was loaded (g 400000).


Yahoo! Finance Tax Center - File online. File on time.
http://taxes.yahoo.com/filing.html

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

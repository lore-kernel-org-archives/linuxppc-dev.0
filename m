From: David Updegraff <dave@cray.com>
Message-Id: <200306032339.SAA37882@engcafe.us.cray.com>
Subject: Re: CRAMFS or SQUASHFS
To: robin.gilks@tait.co.nz (Robin Gilks)
Date: Tue, 3 Jun 2003 18:39:37 -0500 (CDT)
Cc: linuxppc-embedded@lists.linuxppc.org (linuxppc embedded)
In-Reply-To: <3EDD296F.FA278C9C@tait.co.nz> from "Robin Gilks" at Jun 04, 2003 11:04:15 AM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


We ended up with squashfs since it gave better compression, better runtime
performance, and -- most importantly for us -- the 'mksquashfs' suite is
easy to compile up on non-Linux unixes, and it handles endiannes issues.

>
>
> Greetings
>
> I've been trying to determine the best Flash based *_read-only_* compressed
> filesystem for an embedded system.
>
> I can find nothing about CRAMFS - not even what it stands for - is it CRAM as in
> squeeze it all in or Compressed RAM meaning it uses loads of RAM to expand into.
> Just a hint in the right direction here would help!!
>
> For SQUASHFS, I'm unsure as to how mature it is and what its memory overhead is
> since its using zlib - would the discussions about sharing zlib workspace be
> relevant here as well?
>
> Does anyone have a horror story particular to either of these technologies?
>
> Many thanks...
>
> --
> Robin Gilks
> Senior Design Engineer              Phone: (+64)(3) 357 1569
> Tait Electronics                          Fax  :  (+64)(3) 359 4632
> PO Box 1645 Christchurch        Email : robin.gilks@tait.co.nz
> New Zealand
>
>
>


--
Dave Updegraff, Cray Inc. / dave@cray.com / 218-525-1154

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

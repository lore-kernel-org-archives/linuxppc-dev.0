Date: Wed, 04 Jun 2003 11:04:15 +1200
From: Robin Gilks <robin.gilks@tait.co.nz>
Subject: CRAMFS or SQUASHFS
To: linuxppc embedded <linuxppc-embedded@lists.linuxppc.org>
Message-id: <3EDD296F.FA278C9C@tait.co.nz>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Greetings

I've been trying to determine the best Flash based *_read-only_* compressed
filesystem for an embedded system.

I can find nothing about CRAMFS - not even what it stands for - is it CRAM as in
squeeze it all in or Compressed RAM meaning it uses loads of RAM to expand into.
Just a hint in the right direction here would help!!

For SQUASHFS, I'm unsure as to how mature it is and what its memory overhead is
since its using zlib - would the discussions about sharing zlib workspace be
relevant here as well?

Does anyone have a horror story particular to either of these technologies?

Many thanks...

--
Robin Gilks
Senior Design Engineer              Phone: (+64)(3) 357 1569
Tait Electronics                          Fax  :  (+64)(3) 359 4632
PO Box 1645 Christchurch        Email : robin.gilks@tait.co.nz
New Zealand


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

Date: Thu, 13 Mar 2003 12:22:32 -0500
From: Kent Borg <kentborg@borg.org>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Hardcoded Hash_base?
Message-ID: <20030313122232.F3222@borg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In arch/ppc/mm/hashtable.S Hash_base is hardcoded at 0xc0180000, with
a comment suggesting that that value is "just an example".  It seems
to be colliding with my initrd, so I am thinking I want to move it.

What restrictions are there for where it goes?  Why doesn't it get
defined from the link?  How is it that other things are supposed to be
kept clear of it?  (Because it is in an mm-directory, does that mean
that the memory manager knows not to allocate that RAM?)

Thanks for any help,

-kb


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

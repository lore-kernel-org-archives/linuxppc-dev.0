Subject: kernel panic in slab.c
From: Hubert Figuiere <hub-linux-ppc@trantor.staff.proxad.net>
To: linuxppc-dev@lists.linuxppc.org
Content-Type: text/plain; charset=iso-8859-15
Message-Id: <1064493093.17039.44.camel@trantor.staff.proxad.net>
Mime-Version: 1.0
Date: Thu, 25 Sep 2003 14:31:33 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I'm getting kernel panics (during boot up or 5 minutes after, it depends
of the wind, the external temperature, or how old is the captain ;-) )
when I activate CONFIG_SLAB_DEBUG.

Here is the output:
kernel BUG at slab.c:1263!
Oops: Exception in kernel mode, sig: 4

Anybody have had the same problem ?
Disabling DEBUG is fine, but I was really wondering why I was getting
this.

kernel is linux-2.4-devel BK tree in version 2.4.23-pre5


Hub
--
Hubert Figuière - Freebox SA. - +33 1 73 50 2 563
AIM/Yahoo!: hfiguiere, ICQ: 307453487

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

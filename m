Date: Tue, 14 Oct 2003 11:36:04 +0200
From: Olaf Hering <olh@suse.de>
To: Colin Leroy <colin@colino.net>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Fw: [PATCH] Right-click modifier
Message-ID: <20031014093604.GC29143@suse.de>
References: <02cc01c39231$dce0d200$3cc8a8c0@ANOSP>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <02cc01c39231$dce0d200$3cc8a8c0@ANOSP>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


 On Tue, Oct 14, Colin Leroy wrote:

> [Forwarding, just in case.]
>
> > Hi,
> >
> > this patch adds an entry in /proc,
> > /proc/sys/dev/mac_hid/rclick_key_modifier.
> >
> > It lets the kernel report a right-click when KEY+Left click are pressed,
> > where KEY is the KEY specified by echoing its code to the /proc entry.

Its certainly a nice thing, but all this mouse button emulation stuff
should be handled in userland. Its just the question how and where.

--
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Date: Tue, 8 Jun 2004 10:35:32 +0200 (CEST)
From: Marius Groeger <mgroeger@sysgo.com>
To: "Kevin P. Dankwardt" <k@kcomputing.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Fast boot times
In-Reply-To: <KCEOLLHGFJIAFNAMGACHIEGADMAA.k@kcomputing.com>
Message-ID: <Pine.LNX.4.56.0406081032100.2107@mag.sysgo.com>
References: <KCEOLLHGFJIAFNAMGACHIEGADMAA.k@kcomputing.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Kevin,

On Mon, 7 Jun 2004, Kevin P. Dankwardt wrote:

> I am participating in a project that has a challenging boot time
...
> Does anyone have any leads/ideas for being able to meet this deadline?

I once had the (probably rather weird) idea than one could port the
swsusp.sf.net stuff to PPC to shorten the boot time. Don't know if
it's really saving that much, though, since the driver modules need to
be unloaded/loaded anyway.

Regards,
Marius

--
Marius Groeger <mgroeger@sysgo.com>           Project Manager
SYSGO AG                      Embedded and Real-Time Software
Voice: +49 6136 9948 0                  FAX: +49 6136 9948 10
www.sysgo.com | www.elinos.com | www.osek.de | www.imerva.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

Subject: Re: TiBook, 1394, iPod working (sort of  ;-)
To: erbenson@alaska.net (Ethan Benson)
Date: Tue, 27 Nov 2001 09:28:47 -0800 (PST)
Cc: linuxppc-dev@lists.linuxppc.org (linuxppc)
In-Reply-To: <20011126231944.E10071@plato.local.lan> from "Ethan Benson" at Nov 26, 2001 11:19:45 PM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20011127172847.33B512B54A@marcus.pants.nu>
From: flar@pants.nu (Brad Boyer)
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Ethan Benson wrote:
> On Mon, Nov 26, 2001 at 05:33:51PM -0800, Ira Weiny wrote:
> > 1) How are things with HFS+?  I don't know much but have done some poking
>
> for all appearances its abandoned.  the only sign of anything
> happening with it is someone starting a sourceforge account for it,
> all this has is the very pre-alpha development code which pretty much
> just spews errors and panics the kernel, the same code that was
> released about a year ago or so.

That would be me. I've almost got stuff working for a 2.4.x kernel,
which is what is in CVS for that project. I haven't had it crash
at all after my last block of rewrites, but it still doesn't work
properly. It seemed more important to fix the crashes, since I wasn't
going to get very far with it crashing all the time. I haven't had
much time to work on it recently.

http://sourceforge.net/projects/linux-hfsplus/

> i don't know much about this, its probably not significant, certainly
> not to linux since it has zero support for any revision of HFS+,
> outside of the userland hfsplusutils.

Well, according to Apple's documentation, the only version of HFS+
is version 4, so I have no idea what's up with that...

	Brad Boyer
	flar@allandria.com


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

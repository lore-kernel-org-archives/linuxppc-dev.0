Message-ID: <3919F966.F89F577B@charter.net>
Date: Wed, 10 May 2000 19:05:58 -0500
From: "Dan A. Dickey" <ddickey@charter.net>
MIME-Version: 1.0
To: Jason Wohlgemuth <jsw-embedded@mindspring.com>
CC: Julia Elbert <jelbert@enerdyne.com>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: Flash File System
References: <NCBBKJKKGDLPHKDPAFFMIEHDCEAA.jsw-embedded@mindspring.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Jason Wohlgemuth wrote:
> Julia,
> You may wish to look at this page:
> http://www.linux-mtd.infradead.org/
>
> I believe this is where we were able to find our FTL, basically we have some
> spare flash on our board and we point this driver at a chunk of it.  It in
> turn makes Linux see it as a raw device which can be formated and mounted.
> Also, upon a quick skim of the page it mentions DiskOnChip drivers as well.

That's the place!  Thanks Jason.
	-Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

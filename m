Date: Tue, 27 Nov 2001 15:20:51 -0800
From: Ira Weiny <iweiny@acm.org>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: TiBook, 1394, iPod working (sort of  ;-)
Message-Id: <20011127152051.65abd20b.iweiny@acm.org>
In-Reply-To: <20011127221834.23360@smtp.wanadoo.fr>
References: <B499780B-E362-11D5-9B27-003065B90BBC@apple.com>
	<20011127221834.23360@smtp.wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 27 Nov 2001 23:18:34 +0100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

>
> No, you didn't ;) In fact, I even think recent MacOS (or is it MacOS X ?)
> may create pure HFS+ volumes without the wrapper.
>
> The main reason for the wrapper was for machines running non-HFS+ capable
> filesystem to display something (where are all my files gone ?) instead
> of proposing you to format the disk, and for the system to be able to
> boot from HFS+ since OldWorld ROMs didn't understand it. Basically, the
> wrapper contains a slim-fast MacOS System file which contains the necessary
> HFS+ support to mount the real volume and continue booting from that.
>

I think this makes sence because with Linux the HFS+ partition on my HD shows
up with the "where are all my files gone?" thing.  (Which BTW dropped me into
xmon when I vim'ed it...)  But the iPod did not show up with anything
intelligable.

Must be that the iPod is "pure" HFS+ when the other is a wrapper.

To quote a pointy eared character "Fascinating."

Thanks for the info,
Ira Weiny
iweiny@acm.org


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

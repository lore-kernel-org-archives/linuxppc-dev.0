From: Ryan Nielsen <ran@krazynet.com>
Message-ID: <19990111184309.A87@gondolin>
Date: Mon, 11 Jan 1999 18:43:09 -0800
To: Benjamin Herrenschmidt <bh40@calva.net>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Linux-2.2.0-pre5 SMP broken on PReP?
References: <19990111042611.A152@gondolin> <19990111172913.007726@mail.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <19990111172913.007726@mail.mipsys.com>; from Benjamin Herrenschmidt on Mon, Jan 11, 1999 at 05:29:13PM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt wrote:
> On Mon, Jan 11, 1999, Ryan Nielsen <ran@krazynet.com> wrote:
> 
> >it is crashing in kswapd, not the ncr driver.
> >
> >I got pre6 to work by reverse-patching the kswapd part of mm/vmscan.c down to
> >pre4
> >this is only needed for SMP...
> 
> Linus posted some messages about this on the kernel ML, pre-7 should fix
> all that mess, the memory trashing may finally work fine after all ;-)

He didn't mention SMP/PPC/kswapd, as far as i saw, only try_to_free_pages() etc.
I tried pre-7.gz and it made no difference, reverse-patching kswapd still makes things work.

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]

Date: Mon, 11 Jan 1999 10:54:29 -0600 (CST)
From: Troy Benjegerdes <hozer@drgw.net>
To: Ryan Nielsen <ran@krazynet.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Linux-2.2.0-pre5 SMP broken on PReP?
In-Reply-To: <19990111042611.A152@gondolin>
Message-ID: <Pine.LNX.4.04.9901111050330.926-100000@narn.local.drgw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 11 Jan 1999, Ryan Nielsen wrote:

> On Thu, Jan 07, 1999 at 12:55:22 -0600, Troy Benjegerdes wrote:
> > 
> > After working with 2.1.132 for awhile, I decided it was time to try
> > Linus's 2.2.0-pre5, however I haven't been able to successfully boot with
> > it. I have tweaked code and tried various revisions includeing pre1 and
> > pre4 (pre1 wouldn't compile).
> > 
> > I have been getting crashes in the ncr53c8xx driver, but the dump doesn't
> > seem to be providing valid information.
> 
> it is crashing in kswapd, not the ncr driver.

I suppose I meant 'while starting the ncr driver'. At the time I wasn't
convinced the dump was valid.

Do you (or anyone else) have idea why this patch makes things work again?
Is anyone running pre6 on an SMP box? There are very few SMP-only
references in this patch. Is there something in arch/ppc/mm that needs
updating?

> 
> I got pre6 to work by reverse-patching the kswapd part of mm/vmscan.c down to pre4
> this is only needed for SMP...



--------------------------------------------------------------------------
| Troy Benjegerdes    |       troy@microux.com     |    hozer@drgw.net   |
|    Unix is user friendly... You just have to be friendly to it first.  |
| This message composed with 100% free software.    http://www.gnu.org   |
--------------------------------------------------------------------------


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]

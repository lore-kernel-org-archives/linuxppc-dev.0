Date: Thu, 20 Mar 2003 23:52:50 -0800
From: Ira Weiny <iweiny@acm.org>
Subject: Re: Upgrade Blues 2.4.20 Ben H kernel
In-reply-to: <1047135968.12345.81.camel@zion.wanadoo.fr>
To: linuxppc <linuxppc-dev@lists.linuxppc.org>
Message-id: <20030320235251.2f70362e.iweiny@acm.org>
MIME-version: 1.0
Content-type: text/plain; charset=US-ASCII
References: <20030307095717.1b1bece1.iweiny@acm.org>
 <1047135968.12345.81.camel@zion.wanadoo.fr>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On 08 Mar 2003 16:06:08 +0100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Fri, 2003-03-07 at 18:57, Ira Weiny wrote:
> > Well I decided it was time to get up to date on my TiBook.
> >
> >
> > 1) My Microdrive which I had hacked in does not work any more.  What is the
> >    status of the ide-cs driver?  Anyone know?  It is different than when I got
> >    it to work before and I am not sure where to begin again.
>
> There are some problems with ide-cs currently. I'll try to work on it
> this week-end.
>

At the risk of sounding ignorant I have some more information about ide-cs.

I rebooted into 2.4.15 and noted the addresses which the driver uses to talk to
the card.  I have also been able to print the address used in the new kernel
and they are the same address range.  So I must assume that the machine check
is due to something not being set up in the PPC architecture?

What I don't understand is that there does not seem to be anything in
request_region which is PPC specific.  I am sure I am missing something.  I
don't know exactly what a machine check is but, I got this from a book I found:


The causes for machine check exceptions are implementation-dependent, but
typically these causes are related to conditions such as bus parity
errors or attempting to access an invalid physical address.


Why on the first kernel would this address be ok and on the newer version not?
I assumed there would be something in request_region, but I do not see anything
in there PPC specific or architecture specific for that matter.

I don't know if this helps but I am learning...  ;-)

Ira


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

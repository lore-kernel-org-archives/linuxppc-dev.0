Message-ID: <38794090.8D116362@charter.net>
Date: Sun, 09 Jan 2000 20:14:40 -0600
From: Dan Dickey <ddickey@charter.net>
MIME-Version: 1.0
To: Dan Malek <dan@netx4.com>
CC: "linuxppc-embedded@lists.linuxppc.org"
 <linuxppc-embedded@lists.linuxppc.org>,
        Linux PPC Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: MPC850 Development Board - with SDRAM
References: <38777E93.2BE51FEE@charter.net> <38791AAD.F3EBA3A2@netx4.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Dan Malek wrote:
> 
> Dan Dickey wrote:
> 
> > yes - I have an RPX Lite sitting right next to me.
> > But, apparently Embedded Planet doesn't have any
> > development boards with SDRAM on them.
> 
> Embedded Planet does not build development boards, they
> build production boards for OEMs to integrate into products
> to reduce development cost and risk.

Sorry - didn't mean to imply that.  I'm aware of what they
advertise on their web page (http://www.embeddedplanet.com/)
and how some of it is used.  I'm not sure that any "smaller"
companies actually make powerpc development systems - instead,
I can only find them at Motorola and IBM, and ???.

>   There is always
> a debate about EDO versus SDRAM.  Their design started wtih
> EDO, and since it continues to be available with both
> competitive cost and performance there isn't a reason to
> change the design.
> 
> Products that wish to use SDRAM do so by placing it on their
> boards that connect to the Embedded Planet board.  This allows
> the flexibility to add the necessary amount of memory for
> the product requirements.  You can use the UPMB signals from
> the RPX-Lite processor bus connector in your design if you
> require SDRAM.
> 
>         -- Dan

Yes, I've become a little more aware of this situation since
claiming the above.  Here's a message I received from
Robert Applebaum (who works for Embedded Planet I believe).
He gave permission to repost this to the list.

Robert Applebaum wrote:
> 
> Dan, we use EDO on CPU boards, but have PC100 SDRAM on new IO cards such as
> the VEXC which use the UPM B (the EDO on UPM A are used as a single Heap)
> 
> all our new products have SDRAM

I haven't responded back to Robert yet; but I'm intrigued by the
last line - is there a system in the works that has SDRAM on it?
(And no EDO).  Time will tell.

And yes - I'm aware that Embedded Planet isn't in the
development system market - but you do have to admit, their
boards also fulfill that requirement pretty well.  :)
	-Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Message-ID: <39413DC8.C2BE7490@motorola.com>
Date: Fri, 09 Jun 2000 13:56:08 -0500
From: "Richard Hendricks" <richard.hendricks@motorola.com>
MIME-Version: 1.0
To: Kirk Haderlie <khaderlie@vividimage.com>
CC: "'linuxppc-embedded@lists.linuxppc.org'"  <linuxppc-embedded@lists.linuxppc.org>,
        "Frank Fadich (E-mail)" <ffadich@wyle.com>
Subject: Re: Running the 823 FADS board @ 72 MHZ
References: <319E391E2049D311843500609457383D07FC48@exchange.vividimage.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I do not know of any *development* board that is running the faster
speed CPU's in 1:1 mode.  I *do* know several customers are running
their designs at 66 MHz 1:1.  There is also at least 1 customer I
know of running 75 Mhz 1:1 without problems.  I wrote an application
note describing how to do a high-speed SDRAM interface to the MPC823.
Hint: PC66 will NOT work at 66 MHz.  PC100 in most cases won't even
work at 75 MHz.  If you are interested in the app note, I recently
published it on comp.sys.powerpc.tech

Kirk Haderlie wrote:
>
> Are you aware of a development board that is running the faster speed CPU's?
> We need the faster speed for our application.
>
> -----Original Message-----
> From: Richard Hendricks [mailto:richard.hendricks@motorola.com]
> Sent: Friday, June 09, 2000 9:44 AM
> To: 'linuxppc-embedded@lists.linuxppc.org'
> Subject: Re: Running the 823 FADS board @ 72 MHZ
>
> The FADS board are not designed to run at that speed.  Just for kicks,
> I've tried seeing how fast I can go without problems.  At about 60 MHz
> the SDRAM no longer works, and 68 MHz the DRAM starts not working.  This
> is with the default 50 MHz tables.  With better tuning, it may be
> possible
> to go higher, but I doubt you could reach 72 MHz with the FADS.
>
> Kirk Haderlie wrote:
> >
> > We are trying to run the FADS board @ 72MHz and enjoying the infamous UPM
> > tables.  Has anyone successfully run the FADS board at this speed and if
> so
> > would you be willing to share your UPM tables.  We  are trying to set them
> > up for the SDRAM and 60-ns EDO DRAM.
> >
> > Kirk Haderlie
> > kirk@vividimage.com
> > Vivid Image Engineering
> >
>
> --
> MPC823 Applications Engineering Development
> Get help from other MPC823 customers on the
> comp.sys.powerpc.tech newsgroup!
>

--
MPC823 Applications Engineering Development
Get help from other MPC823 customers on the
comp.sys.powerpc.tech newsgroup!

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

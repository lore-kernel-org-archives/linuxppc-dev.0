Message-ID: <39411EED.368F2707@motorola.com>
Date: Fri, 09 Jun 2000 11:44:29 -0500
From: "Richard Hendricks" <richard.hendricks@motorola.com>
MIME-Version: 1.0
To: "'linuxppc-embedded@lists.linuxppc.org'"  <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Running the 823 FADS board @ 72 MHZ
References: <319E391E2049D311843500609457383D07FC47@exchange.vividimage.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


The FADS board are not designed to run at that speed.  Just for kicks,
I've tried seeing how fast I can go without problems.  At about 60 MHz
the SDRAM no longer works, and 68 MHz the DRAM starts not working.  This
is with the default 50 MHz tables.  With better tuning, it may be
possible
to go higher, but I doubt you could reach 72 MHz with the FADS.

Kirk Haderlie wrote:
>
> We are trying to run the FADS board @ 72MHz and enjoying the infamous UPM
> tables.  Has anyone successfully run the FADS board at this speed and if so
> would you be willing to share your UPM tables.  We  are trying to set them
> up for the SDRAM and 60-ns EDO DRAM.
>
> Kirk Haderlie
> kirk@vividimage.com
> Vivid Image Engineering
>

--
MPC823 Applications Engineering Development
Get help from other MPC823 customers on the
comp.sys.powerpc.tech newsgroup!

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

To: "Joao Vicente" <joao.vicente@spectel.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Problem debugging ppc kernel with DDD/GDB/BDI2000 on a custom MPC8260 board 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 15 Oct 2003 18:47:11 BST."
             <DEF39A0710293E489D45B10E06645CBD0243B3B2@dub-msx1.spectelcorp.com>
Date: Wed, 15 Oct 2003 19:56:27 +0200
Message-Id: <20031015175632.21AB5C59E4@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Joao,

in message <DEF39A0710293E489D45B10E06645CBD0243B3B2@dub-msx1.spectelcorp.com> you wrote:
>
> on u-boot IMMR was set to 0x04700000, which is acceptable as far as
> u-boot is concerned, but not allowed once the kernel is initialised.
>
> The other issue was that the Chip Select was not configured properly on
> u-boot (2MB instead of 32MB), which was not noticed in u-boot since the
> u-boot never tried to access memory above that region, but caused the
> kernel to reset the target.
...
> I am using the denx distribution linuxppc_2_4_devel, and I am
> configuring it using the TQM8260 default configuration, customising some
> CPM settings for UART and FEC.

I would like to point out that you certainly did NOT pick up  such  a
bogus memory map from the TQM8260 default configuration, nor from any
other board maintened by DENX.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Old programmers never die, they just branch to a new address.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

To: Greg Watson <gwatson@lanl.gov>
Cc: "Jack Liu" <Jack_liu@usish.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Sandpoint problems 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 16 Feb 2004 09:42:35 MST."
             <1FF3FFE3-609F-11D8-A367-000393A47A5C@lanl.gov>
Date: Mon, 16 Feb 2004 18:12:35 +0100
Message-Id: <20040216171240.9276EC108D@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <1FF3FFE3-609F-11D8-A367-000393A47A5C@lanl.gov> you wrote:
>
> The sandpoint has at least two (sometimes three) flash parts. The one
> containing DINK is on the PCI bus on the motherboard. One or two other
> flash parts are on the PrMC card connected to the local memory bus. It
> is normal to leave DINK alone and program one of the other flash parts
> with an alternate boot loader. There are a series of dip switches that
> switch between programming and booting from the various flash parts.
> Unfortunately the documentation for the switch positions is very
> confusing and unless you get it exactly right the board will not boot.

U-Boot comes with a file doc/README.Sandpoint8240 which explains  all
the required details.

Best regards,

Wolfgang Denk

--
See us @ Embedded World, Nuremberg, Feb 17 - 19,  Hall 12.0 Booth 440
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Beware of the Turing Tar-pit in  which  everything  is  possible  but
nothing of interest is easy.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

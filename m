To: Tom Rini <trini@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: boot methods 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 02 Nov 2001 18:55:47 MST."
             <20011102185547.B29932@cpe-24-221-152-185.az.sprintbbd.net>
Date: Sat, 03 Nov 2001 10:45:37 +0100
Message-Id: <20011103094543.10BDA10CDB@denx.denx.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


In message <20011102185547.B29932@cpe-24-221-152-185.az.sprintbbd.net> you wrote:
>
> Vendor                Extension               How
> IBM Spruce            .spruce                 ???
> Force PowerCore       .pcore                  PowerBoot (Force firmware)
> Force PowerPMC 250    .pcore                  PowerBoot
> M.E.N. F1             .menf1                  ??? (Probably custom fw).
> Motorola LoPEC        .pplus/.bugboot[1]      PPCBUG
> Motorola MCPN765      same                    same
> Motorola MVME5100     same                    same
> Motorola PrPMC750     same                    same
> Motorola PrPMC750     same                    same
> Motorola Sandpoint    .sandpoint              DINK32

also: Sandpoint         .PPCBoot		PPCBoot


> SBS Adirondack        - Uses runlnx, no in-kernel booting bits
> SBS K2                .k2                     pmon
> Zynx 4500             .zx4500                 ??

add:

  "CU824" Board (8240)
  Microsys Electronics	.PPCBoot		PPCBoot

  MOUSSE Board (8240)	.PPCBoot		PPCBoot

  EVB64260 (74xx)	.PPCBoot		PPCBoot

> Why is the how important?  With the exception of firmware-deficiencies,
> the current wrapper doesn't really care what it came from.  And they

...or there is no wrapper at all.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
You are only young once, but you can stay immature indefinitely.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

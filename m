Subject: Re: [PATCH][RFC]Updated MPC I2C driver
From: Matthew McClintock <mcclintock@freescale.com>
Reply-To: mcclintock@freescale.com
To: Sylvain Munaut <tnt@246tnt.com>
Cc: Adrian Cox <adrian@humboldt.co.uk>,
	Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>,
	"Kumar K. Gala" <kumar.gala@motorola.com>,
	Matthew McClintock <mcclintock@motorola.com>
In-Reply-To: <40E463E5.1060401@246tNt.com>
References: <1088705955.28598.168.camel@localhost>
	 <40E463E5.1060401@246tNt.com>
Content-Type: text/plain
Message-Id: <1088696887.7555.70.camel@matthew-laptop>
Mime-Version: 1.0
Date: Thu, 01 Jul 2004 15:48:07 +0000
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


The blocks look very similar, you might want to look at the follow up
patch I just sent that abstracts the read/writes. It might be as simple
as abstracting another read/write function for your particular platform.

Regards,
Matthew

On Thu, 2004-07-01 at 19:20, Sylvain Munaut wrote:
> Adrian Cox wrote:
>
>  > This version should support MPC8540 as well as MPC8245 and MPC107.
>  > I don't have MPC85xx hardware, so I'd like feedback from people who
>  > do.
>  >
>  > To use it on MPC107/824x requires the OCP patch that went by on the
>  > list on Tuesday. The support for MPC85xx is already in the kernel.
>  >
>  > If nobody has any complaints I'm ready to send it to Greg K-H.
>
>
> Interesting, it really looks like the MPC5200 I2C controller.
> Unfortunatly :
>  - On the MPC5200, all the status/controls bits are in the MSBs ( so
> the consts would need to be << 24 )
>  - And there is a interrupt control register I don't see in your code.
> It's shared by the two I2C controllers onboard.
>
> I'll try to see if I can make it work on the lite5200 board.
>
> Sylvain Munaut
--
Matthew McClintock <mcclintock@freescale.com>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

Message-ID: <3DD3D715.8BA00B56@phx.mcd.mot.com>
Date: Thu, 14 Nov 2002 10:02:13 -0700
From: Tom Armistead <Tom_Armistead@phx.mcd.mot.com>
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
Cc: ???? <yuj@mail.ndsc.com.cn>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: motorola lopec mpc7410
References: <200211140848.CAA19190@lists.linuxppc.org> <20021114151038.GA14431@opus.bloom.county>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> On Thu, Nov 14, 2002 at 04:50:34PM +0800, ???? wrote:
>
> >  I'm porting mvista linux 2.1 for the motorola lopec mpc7410 board.And I noticed that there are some differences between the board version described by mvista and motorola.Also,the version of PPCBug is different.I'm wondering why?
>
> For support for an MontaVista product, please contact your mvista sales
> rep (or perhaps your manager knows) to find out how to contact support.
>
> Having said that, I _believe_ the LoPEC I have running right now has
> PPC6Bug, so perhaps you should contact Motorola to find out how to
> upgrade the firmware.
>
> --
> Tom Rini (TR1265)
> http://gate.crashing.org/~trini/
>

PPC5Bug is the firmware for Lopec.  The last released version for Lopec is PPC5Bug 1.4 RM02 but it is unlikely that upgrading the firmware (from 1.3) would have any effect on the described problem.   I don't know much about Linux but my
guess is that something is misconfigured in your kernel (console IO would be the first thing I'd check...).

The PPC6Bug series was for the Hawk based products (MCPN765, MVME5100, PPMC750, etc..).  I don't think any version of PPC6Bug will work at all on Lopec.

Tom Armistead


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

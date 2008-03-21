Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from mail114-dub-R.bigfish.com (mail-dub.bigfish.com
	[213.199.154.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id BE720DDFCB
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Mar 2008 03:50:41 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 2/3] [POWERPC] Xilinx: of_serial support for Xilinx
	uart16550.
Date: Fri, 21 Mar 2008 09:50:36 -0700
In-Reply-To: <0a442bfb97492bd8d687678480c6217a@kernel.crashing.org>
References: <12060242324116-git-send-email-john.linn@xilinx.com>	<20080320144402.3063517C005D@mail148-sin.bigfish.com><fa686aa40803201719i7bf02ba2qd259f1a36a24d943@mail.gmail.com><47E3B189.6060002@ru.mvista.com><75a17dc1bd4e99a473ed679ccf9b210f@kernel.crashing.org><47E3DA40.6000007@ru.mvista.com>
	<0a442bfb97492bd8d687678480c6217a@kernel.crashing.org>
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: "Segher Boessenkool" <segher@kernel.crashing.org>,
	"Sergei Shtylyov" <sshtylyov@ru.mvista.com>
Message-Id: <20080321165034.6D7F2440086@mail114-dub.bigfish.com>
Cc: John Linn <linnj@xilinx.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: =
linuxppc-dev-bounces+stephen.neuendorffer=3Dxilinx.com@ozlabs.org
[mailto:linuxppc-dev-
> bounces+stephen.neuendorffer=3Dxilinx.com@ozlabs.org] On Behalf Of
Segher Boessenkool
> Sent: Friday, March 21, 2008 9:46 AM
> To: Sergei Shtylyov
> Cc: linuxppc-dev@ozlabs.org; John Linn
> Subject: Re: [PATCH 2/3] [POWERPC] Xilinx: of_serial support for
Xilinx uart16550.
>=20
> >    The proposed use clearly would treat them as generic, since in
the
> > context of the Xilinx UART they're just not needed -- it's known
> > beforehand and most probably fixed how/where the registers are
mapped.
> > There's just no need for such info in the device tree -- unless
you're
> > going to teach the *generic* driver to handle this specific (and
> > possibly others alike) kind of a device.
>=20
> I was under the impression that the "xilinx uart" was just a 16550 (or
> so)
> with its registers wired up in a slightly unusual way.  If it's a
> completely
> different device, of course you need a separate binding, and you might
> not
> want reg-shift properties etc. there.

It's a standard 16550, with registers in the standard order, but at
offsets 3,7,11, etc.

Steve

Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.246])
	by ozlabs.org (Postfix) with ESMTP id 9A517DE39A
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Apr 2008 02:04:26 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c37so160038anc.78
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Apr 2008 09:04:21 -0700 (PDT)
Message-ID: <fa686aa40804110904y1a35d4aem329439eb6e765e68@mail.gmail.com>
Date: Fri, 11 Apr 2008 10:04:20 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Guillaume Dargaud" <dargaud@lpsc.in2p3.fr>
Subject: Re: zImage.embedded
In-Reply-To: <016801c89beb$fbff6de0$ad289e86@LPSC0173W>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <014701c89bda$09380060$ad289e86@LPSC0173W>
	<fa686aa40804110655x48120e84tde01a52d8bb39a3@mail.gmail.com>
	<016801c89beb$fbff6de0$ad289e86@LPSC0173W>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Apr 11, 2008 at 9:51 AM, Guillaume Dargaud
<dargaud@lpsc.in2p3.fr> wrote:
>
> >
> > >  is the file zImage.elf my proper network image ?
> > >
> >
> > What bootloader is on your board?  zImage.elf *might* be the proper
> > image.  If you're using u-boot, then you want to build a uImage
> > instead.
> >
>
>  I... ahem... what would you recommand for a ML405 ?
>  Builroot gives to options of U-Boot or Yaboot. Haven't tried either yet.
> Will do on tuesday.
>
>  I don't know if Xilinx has another solution (I remember seeing some boot
> function in the API, usable from a standalone elf file).

zImage.elf is what you want.  If you *do* get u-boot building on your
board, then you'll want a uImage; but zImage.elf will work for you
now.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

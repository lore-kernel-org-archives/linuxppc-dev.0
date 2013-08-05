Return-Path: <pladow@gmail.com>
Received: from mail-la0-x233.google.com (mail-la0-x233.google.com
 [IPv6:2a00:1450:4010:c03::233])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C3D082C007A
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Aug 2013 08:11:57 +1000 (EST)
Received: by mail-la0-f51.google.com with SMTP id fp13so2498742lab.10
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Aug 2013 15:11:51 -0700 (PDT)
MIME-Version: 1.0
Sender: pladow@gmail.com
In-Reply-To: <5200143F.9010307@ovro.caltech.edu>
References: <CAN8Q1Ed-YtD1L7e9TaJyELdcz5Rcfdi0mdwU_H6HAx0-3FJ4Lg@mail.gmail.com>
 <20130805202559.0086e806@crub>
 <CAN8Q1EfoLTDr-x0r82Ezpqak+R=QuL1o37_OVU3Q0=8zFfDMqA@mail.gmail.com>
 <52000ACA.1010606@ovro.caltech.edu>
 <CAN8Q1EcnT3We1X22pw4AQ28xmd2d-XB9nTzZ2KdVb=qOx4j7-Q@mail.gmail.com>
 <5200143F.9010307@ovro.caltech.edu>
Date: Mon, 5 Aug 2013 15:11:51 -0700
Message-ID: <CAN8Q1EdtAB5kV=KoUBbnDXRbNr6w8A1ZK_dFkfEVOzUaycEVuQ@mail.gmail.com>
Subject: Re: Failure to detect PCI card
From: Peter LaDow <petela@gocougs.wsu.edu>
To: David Hawkins <dwh@ovro.caltech.edu>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Anatolij Gustschin <agust@denx.de>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Aug 5, 2013 at 2:08 PM, David Hawkins <dwh@ovro.caltech.edu> wrote:
> My analyzer has an extender card that you first plug in, and then
> plug the board into that ... any chance someone in your organization
> has one of those cards? Alternatively, confirm the board works in
> a machine that has more than one slot, and if it does not, use the
> analyzer to see what is happening.

Mine has an extender as well, but it is a 5V only extender (such as
the one you pointed out).  I'll ask the HW guys if they have a 3V
somewhere.

Now, I'm not a PCI expoert, but, I can do PCI transactions via u-boot.
 And probing the PCI space via u-boot reveals nothing on 00:14.0 (the
place where our 82540 typically shows up).  Indeed, it returns all
FF's, so I presume that means nothing is there.  And enabling PCI_ENUM
is u-boot causes an exception when I try 'pci enum' (with an older
version of u-boot) or hangs u-boot (in 2013.07).

> If you're looking for a PCI target that you can completely control,
> then if you have an "FPGA guy" in your company, perhaps he can
> dig up a low-cost PCI card that you can configure as a PCI master
> to emulate the functions of a network card.

Well, we do have an FPGA hanging off the bus.  But getting an RTL guy
to do this....hmmm.  I'll have to explore more.

> Actually, before going down that route, I would get a PCI extender
> that you can use to trace the traffic with your board. Does the
> network card use 33MHz or 66MHz?

It's at 33MHz.  I just need to find a 3V extender somewhere...

Thanks,
Pete

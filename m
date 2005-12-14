Return-Path: <alebas@televes.com>
Received: from tvesnat.televes.com (unknown [212.163.42.137])
	by ozlabs.org (Postfix) with ESMTP id 2217F68880
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 15 Dec 2005 00:08:17 +1100 (EST)
Message-ID: <1134569602.43a0288234662@webmail.televes.com:443>
Date: Wed, 14 Dec 2005 15:13:22 +0100
From: Alex BASTOS <alebas@televes.com>
To: Vitaly Bordug <vbordug@ru.mvista.com>
References: <1134555662.439ff20e6e812@webmail.televes.com:443>
	<43A0021E.7030406@ru.mvista.com>
In-Reply-To: <43A0021E.7030406@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: [SOLVED] Re: pq2_find_bridges hangs system 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Vitaly,

> Maybe, but I guess more correct is to deal with USB->PCI dependency..
> Is it really needed(I am not USB expert)?

Neither am I. I guess for this Host Controler it is not needed at
HW level, but I am not sure why it is still required by the SW.


> > 3) I have seen that from u-boot, a reset occurs when I read Internal
> > Memory at offset 0x10904 (PCI CFG_DATA). From BDI, when I do the same
> > all PCI section on IM becomes zero. Is this a known behaviour? May this
> > reflect a hardware problem?
> >
> Sounds weird

Here is the problem. The cause for this weird behaviour is that I
had PCI_ARBITER_EN_  disabled. So, a HW problem at the end.
I had disabled it trying to reduce power compsumption due to the PCI,
as I am not going to use it. It seems it is not possible that way.
Any idea how to get this done?

> > In conclusion, 1) solves my "must", a working board (without PCI).
> > But I still would like to know what am I doing so wrong with this.
> >
> IMHO ability to disable PCI_8260 while PCI is on might be confusing, at least
> for upstream.

You are right.

Thanks so much for your help.

Best regards,

Alex

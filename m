Return-Path: <antonio.dibacco@aruba.it>
Received: from smtpa3.aruba.it (smtpa4.aruba.it [62.149.128.201])
	by ozlabs.org (Postfix) with SMTP id 97175679E6
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 18 Mar 2006 02:21:49 +1100 (EST)
From: Antonio Di Bacco <antonio.dibacco@aruba.it>
To: linuxppc-embedded@ozlabs.org
Subject: Re: 8xx SMC1 problem
Date: Fri, 17 Mar 2006 16:25:48 +0100
References: <004B1D7A5257174C9044A1B7BD0E60ED0178CC6A@ratatosk.combitechsystems.com>
In-Reply-To: <004B1D7A5257174C9044A1B7BD0E60ED0178CC6A@ratatosk.combitechsystems.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200603171625.49047.antonio.dibacco@aruba.it>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I tried directly with console=3D/dev/null and then I was able to use the se=
rial=20
port from an application.

Bye,
Antonio.


On Friday 17 March 2006 07:55, Bj=F6rn =D6stby wrote:
> >From: wd@denx.de [mailto:wd@denx.de]
> >Sent: den 16 mars 2006 21:10
> >To: Bj=F6rn =D6stby
> >Cc: linuxppc-embedded@ozlabs.org
> >Subject: Re: 8xx SMC1 problem
> >
> >In message <004Bxxxxx@ratatosk.combitechsystems.com> you wrote
> >
> >> First of, I have three serial ports (SMC1, SMC2 and SCC3) and they all
> >> work  fine when the console is on SMC1. I have gadgets connected to
> >> SMC2 and SCC 3 and now I need SMC1 for yet another device. So I have
> >> undefined CONFIG_SE RIAL_CONSOLE in the kernel config and I jump out
> >> of u-boot (which have the console on SMC1) with the argument
> >> "console=3Dnone".
> >
> >And did you make sure that no other process is accessing ttyS0 ?
> >
> >> When logging in (via telnet) ttyS0 works no more (but S1 and S2 does).
> >> At r andom bootups, it is possible to open the port but it is no good
> >> for read o r write.
> >>
> >> Can anybody give me some advise on how to enable SMC1 but at the same
> >> time don't have a console on it?
> >
> >We did the same (passing console=3Dnull) in a couple of  configurations =
and
> >had  no  problems  >using SMC1 as standard serial port. Try *not*
> > undefining CONFIG_SERIAL_CONSOLE.
>
> Ahh, "console=3Dnull" worked a lot better than "console=3Dnone".
> Problem solved!
>
> >And please keep your line length < 72 characters or so.
>
> I'll see to that.
>
>
> Regards,
> Bj=F6rn =F6stby
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded

Return-Path: <mathieu.deschamps@com2gether.net>
Received: from mail.libertysurf.net (mx-out.libertysurf.net [213.36.80.91])
	by ozlabs.org (Postfix) with ESMTP id 9F8CA679F0
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 22 Feb 2006 03:43:39 +1100 (EST)
From: Mathieu Deschamps <mathieu.deschamps@com2gether.net>
To: Wojciech Kromer <wojciech.kromer@dgt.com.pl>
Subject: Re: Uart on cpm2_io (was: Using modem signal in cpm2 uart for MPC8270)
Date: Tue, 21 Feb 2006 17:44:03 +0100
References: <200602210954.51248.mathieu.deschamps@com2gether.net>
	<43FADB46.6030109@dgt.com.pl>
In-Reply-To: <43FADB46.6030109@dgt.com.pl>
MIME-Version: 1.0
Message-Id: <200602211743.19539.mathieu.deschamps@com2gether.net>
Content-Type: text/plain;
  charset="utf-8"
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tuesday 21 February 2006 10:20, Wojciech Kromer wrote:
> Dnia 2006-02-21 09:58, U=C5=BCytkownik Mathieu Deschamps napisa=C5=82:
> > Hello,
> >
> > Sorry to come with this UART issue again but I had no answer and no
> > better idea but asking people who knows 82xx uart well, people who
> > designed it.
> >
> > My issue about this uart could be approched elseway : why is there a
> > modem_control conditionnal compilation option when PQ2 SCCs
> > (in normal operation mode which is default) take care of CTS,CD signals
> > (Chap 20-8 GSMR_L register DIAG MPC8280 PQ2 Ref. Manual ) ?
> >
> > I fell like that is clearly a design-time choice matter that I need to
> > clarify.
> >
> > And simply :
> > Is this version is known to be broken when activating this option ?
>
> Do not know what this option is, probably for disabling code from
> another driver.
> With latest CVS version from denx.de you have only to enable CTS/RTS..
> signals in menuconfig.
> (And read my prior post if you're using SCC4 with SCC_CONSOLE)
>
>
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded

Thanks for your reply,

<> Do not know what this option is, probably for disabling code from
<> another driver.
=2E..or rather to enable it...(default is disabled). Allthesame :=20

Now it's clear it has historical reason and that I should not meddle with i=
t=20
in getting it enable. I guess it may be used for non-PQ2 or rather for non=
=20
dedicated pins assignement capable cpu in order to implement thoses signals
handling.

About SCC4 my version includes that code you spoke about in your prior=20
posts, but I'll use SCC4 as usb and not as console. Thus maybe this
turned nouse and has vanished in your version and that's why it's call a=20
"feature enhancement" yet. =20


Best Regards,

=20
Mathieu Deschamps
Com2gether Design Center
Electronic and Embedded Engineering Services
www.com2gether.net=20

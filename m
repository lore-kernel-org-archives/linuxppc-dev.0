Return-Path: <mlcreech@gmail.com>
Received: from mail-vw0-f42.google.com (mail-vw0-f42.google.com
	[209.85.212.42]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6B3641007D8
	for <linuxppc-dev@ozlabs.org>; Fri, 13 May 2011 01:30:55 +1000 (EST)
Received: by vwl1 with SMTP id 1so1729084vwl.15
	for <linuxppc-dev@ozlabs.org>; Thu, 12 May 2011 08:30:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4206182445660643B9AEB8D4E55BBD0A1533BC2780@HERMES2>
References: <BANLkTikp5yVgrCe7tbc4cvG5wvy7XJp2fQ@mail.gmail.com>
	<4206182445660643B9AEB8D4E55BBD0A1533BC2780@HERMES2>
Date: Thu, 12 May 2011 11:30:51 -0400
Message-ID: <BANLkTim8ntQHkcm_yOgD+UQQb+b+tSoFqA@mail.gmail.com>
Subject: Re: fsl_udc_core: BUG: scheduling while atomic
From: "Matthew L. Creech" <mlcreech@gmail.com>
To: Sergej.Stepanov@ids.de
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, May 12, 2011 at 4:37 AM,  <Sergej.Stepanov@ids.de> wrote:
> Hi Mattheew,
>
> such oops you can get also with spi.
> For such problem helps to compile your kernel with other preemption
> model:
> =A0- preempt
> =A0- standard
> =A0- !!! but not voluntary preemption !!!

Thanks Sergej, indeed I'm currently using CONFIG_PREEMPT_VOLUNTARY on
this board.  I'll change it to fix this problem for now.

Do you happen to know whether the Freescale folks intend to fix this?
If not, it seems like at least some sort of warning is in order.

--=20
Matthew L. Creech

Return-Path: <lada.podivin@gmail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 192E1B7043
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  3 Jul 2009 19:09:52 +1000 (EST)
Received: from mail-fx0-f222.google.com (mail-fx0-f222.google.com
	[209.85.220.222]) by ozlabs.org (Postfix) with ESMTP id 49C8BDDD0C
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Jul 2009 19:09:50 +1000 (EST)
Received: by fxm22 with SMTP id 22so2321506fxm.9
	for <linuxppc-dev@ozlabs.org>; Fri, 03 Jul 2009 02:09:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <579B119545DAEF4689C8FBEEFEC5793F01D4FF01A2D0@ATLMBX.verint.corp.verintsystems.com>
References: <e35801cc0906300658q45d5ea00ub939ba73185efd72@mail.gmail.com>
	<COL107-W41E84129BE81739BC96295B22E0@phx.gbl>
	<579B119545DAEF4689C8FBEEFEC5793F01D4FF01A2D0@ATLMBX.verint.corp.verintsystems.com>
Date: Fri, 3 Jul 2009 11:09:47 +0200
Message-ID: <e35801cc0907030209y2a4bd50s7d12cf75341e3536@mail.gmail.com>
Subject: Re: ppc405ex + gigabit ethernet
From: Lada Podivin <lada.podivin@gmail.com>
To: "Cote, Sylvain" <Sylvain.Cote@verint.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Sylvain,

the interrupt coalescing sounds like good idea - I'm surprised this
feature is missing in the original ibm_newemac driver. You wrote you
had got this optimisation directly from AMCC. Is it part of any
framework? I'm just wondering how one can obtain it. I tried to find
any suitable patch but with no success - the old friend Google didn't
help this time :)

Thank you very much!
Lada

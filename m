Return-Path: <glikely@secretlab.ca>
Received: from rn-out-0910.google.com (rn-out-0910.google.com [64.233.170.188])
	by ozlabs.org (Postfix) with ESMTP id 85712DDDEC
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Nov 2008 01:56:11 +1100 (EST)
Received: by rn-out-0910.google.com with SMTP id j40so430571rnf.16
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Nov 2008 06:56:08 -0800 (PST)
Message-ID: <fa686aa40811200656g783947f5l609650b707c6c883@mail.gmail.com>
Date: Thu, 20 Nov 2008 07:56:08 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
To: gianfranco.casanova@alice.it
Subject: Re: USB on lite5200 does not work.
In-Reply-To: <47602D18F269934AB73B7E550804A1E00213796C@FBCMST09V03.fbc.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <47602D18F269934AB73B7E550804A1E00213796C@FBCMST09V03.fbc.local>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Nov 20, 2008 at 7:09 AM,  <gianfranco.casanova@alice.it> wrote:
> Hi folks
>
> I've got a "little" problem with USB using a board based on lite5200.
>
> Some infos:
>
> -uBoot 1.2.0
> -Linux version 2.6.21.7-hrt1-WR2.0bl_standard
> -time_init: processor frequency   = 396.000000 MHz

There have been a lot of changes to MPC5200 support in the last 6
kernel releases.  Can you try with a more recent kernel?

Thanks,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

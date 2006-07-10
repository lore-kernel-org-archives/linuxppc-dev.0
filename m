Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id A65BC67B56
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Jul 2006 03:42:20 +1000 (EST)
Date: Mon, 10 Jul 2006 21:41:58 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: "Rune Torgersen" <runet@innovsys.com>
Subject: Re: ppc -> powerpc porting
Message-ID: <20060710214158.1d8dcf2c@vitb.ru.mvista.com>
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B0189DE5E@ismail.innsys.innovsys.com>
References: <DCEAAC0833DD314AB0B58112AD99B93B0189DE5E@ismail.innsys.innovsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 10 Jul 2006 12:14:24 -0500
"Rune Torgersen" <runet@innovsys.com> wrote:

> To make my life a little easier: Does anybody have a list of stuff to
> watch out for/need to do when porting a board from ppc to powerpc?
> The board uses a Freescale 8265 and runs under 2.6.17, using platfrom
> device support for accessing fs_enet driver.
>
We have mpc8272 under arch/powerpc as work-in-progress, latest fs_enet being merged now.

I think it'll be a week or 2 before first submit, so it may make sense just to wait a bit :)


-- 
Sincerely, 
Vitaly

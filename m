Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 278BCB7CA6
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Feb 2010 23:28:11 +1100 (EST)
Received: from sesr04.transmode.se (sesr04.transmode.se [192.168.201.15])
	by gw1.transmode.se (Postfix) with ESMTP id 830E02597C7
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Feb 2010 13:28:07 +0100 (CET)
In-Reply-To: <OF21CCB5A6.CDFDB6C1-ONC12576D2.00430B25-C12576D2.0043C4BB@LocalDomain>
References: <OF21CCB5A6.CDFDB6C1-ONC12576D2.00430B25-C12576D2.0043C4BB@LocalDomain>
Subject: Re: default stack size for threads changed
Message-ID: <OFDAD82DF5.29DE7FB3-ONC12576D2.0043E8D7-C12576D2.00442549@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Mon, 22 Feb 2010 13:24:19 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Joakim Tjernlund/Transmode wrote on 2010/02/22 13:20:12:
>
> With current, 2.6.33-rc6, linux the default stack size changed from unlimited
> to 8MB:
> # > ulimit -s
> 8192
>
> This makes NPTL allocate a 8MB stack for each thread that is created.
> This breaks in our embedded system. Although this
> can be fixed in our app I wonder if this is intentional?
>
>  Jocke

Forgot to mention that timer_create(2) increases the stack with 8MB too.

 Jocke

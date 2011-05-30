Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E4114B6F72
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 31 May 2011 08:17:22 +1000 (EST)
Subject: Re: PROBLEM: 2.6.39 doesn't boot on POWER MAC
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: kevin diggs <diggskevin38@gmail.com>
In-Reply-To: <BANLkTimLm1DYVWy2Cj-F9hLw3mNsqtk4iQ@mail.gmail.com>
References: <4DE0AA62.4070909@list.ru>
	<BANLkTinZd32+5b=3DdYknBCtQJT0qiNKcg@mail.gmail.com>
	<4DE29B78.1070209@list.ru> <1306705871.7481.594.camel@pasglop>
	<BANLkTimLm1DYVWy2Cj-F9hLw3mNsqtk4iQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 31 May 2011 08:17:04 +1000
Message-ID: <1306793824.7481.622.camel@pasglop>
Mime-Version: 1.0
Cc: Tabi Timur-B04825 <B04825@freescale.com>, Andrey Gusev <ronne@list.ru>,
	"paulus@samba.org" <paulus@samba.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2011-05-30 at 17:11 -0500, kevin diggs wrote:
> Hi,
> 
> >
> > This is an SMP machine ? If not, does it work with a UP kernel ?
> >
> > Cheers,
> > Ben.
> >
> ??? Even if it is SMP, you can run non-SMP kernel on it, right?

Yes, I was asking whether the bug also occured with an UP kernel.

Cheers,
Ben.

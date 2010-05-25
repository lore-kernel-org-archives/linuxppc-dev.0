Return-Path: <martyn.welch@ge.com>
Received: from exprod5og113.obsmtp.com (exprod5og113.obsmtp.com [64.18.0.26])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DEBECB7D51
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 25 May 2010 18:49:12 +1000 (EST)
Message-ID: <4BFB8DCE.8060804@ge.com>
Date: Tue, 25 May 2010 09:43:58 +0100
From: Martyn Welch <martyn.welch@ge.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: mmio_nvram.c users ?
References: <1274773439.1931.238.camel@pasglop>
In-Reply-To: <1274773439.1931.238.camel@pasglop>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

One day I'll manage to hit "Reply" or "Reply All" correctly...

Benjamin Herrenschmidt wrote:
> Hi folks !
>
> Anybody aware of anything other than Cell using that driver ?
>
> I'd like to make it a platform driver instead of having something that
> pokes at anything that has a "device_type" set to "nvram" (which is
> gross and bogus). But I need to know what platforms to fixup...
>
>   

We do on our boards, that would currently be the sbc310, sbc610 and
ppc9a (all FSL 86xx based boards). I also have 2 other boards I'm
currently working on that will also use that driver.

Martyn

> Cheers,
> Ben.
>
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>   


-- 
Martyn Welch (Principal Software Engineer)   |   Registered in England and
GE Intelligent Platforms                     |   Wales (3828642) at 100
T +44(0)127322748                            |   Barbirolli Square, Manchester,
E martyn.welch@ge.com                        |   M2 3AB  VAT:GB 927559189

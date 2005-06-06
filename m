Return-Path: <nguyen.mktm.minh@gmail.com>
Received: from zproxy.gmail.com (zproxy.gmail.com [64.233.162.199])
	by ozlabs.org (Postfix) with ESMTP id CBD0B679EB
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  6 Jun 2005 22:57:53 +1000 (EST)
Received: by zproxy.gmail.com with SMTP id 13so2255426nzp
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 06 Jun 2005 05:57:49 -0700 (PDT)
Message-ID: <50303a96050606055755f37e17@mail.gmail.com>
Date: Mon, 6 Jun 2005 08:57:48 -0400
From: Minh Nguyen <nguyen.mktm.minh@gmail.com>
To: Jarno Manninen <jarno.manninen@tut.fi>
In-Reply-To: <200506052229.44170.jarno.manninen@tut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20050605141556.7B9CA679E6@ozlabs.org>
	<200506052229.44170.jarno.manninen@tut.fi>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Help on the data rate on MPC5200 ethernet
Reply-To: Minh Nguyen <nguyen.mktm.minh@gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Use iperf. You can find the source code at http://dast.nlanr.net/Projects/I=
perf/

mkt

On 6/5/05, Jarno Manninen <jarno.manninen@tut.fi> wrote:
> On Sunday 05 June 2005 17:09, xuetao wrote:
>=20
> > I am testing the tcp/ip data communication data rate on MPC5200. The UD=
P
> > data rate is up to 80Mbps and TCP data rate is only 10Mbps? I test the =
TCP
> > data rate with FTP file traslation. Any body know the problem on this?
>=20
> The mass storage may be the limiting factor here, ofcourse depending on y=
our
> configuration. Anyhow I've found NTTCP test utility usefull for simple
> testing purposes. There's propably some other test suites floating around
> too.
>=20
> - Jarno
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>

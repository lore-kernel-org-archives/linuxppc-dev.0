Return-Path: <rael@edge.ping.de>
Received: from lilly.ping.de (lilly.ping.de [83.97.42.2])
	by ozlabs.org (Postfix) with SMTP id 9E88EDDEBF
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Aug 2007 17:21:35 +1000 (EST)
Date: 27 Aug 2007 09:14:48 +0200
Message-ID: <46D279E8.10001@edge.ping.de>
From: "Tim Teulings" <rael@edge.ping.de>
To: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>,
	"=?ISO-8859-1?Q?Rog=E9rio_Brito?=" <rbrito@gmail.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	debian-powerpc@lists.debian.org, "Rafael J. Wysocki" <rjw@sisk.pl>,
	"Linux-pm mailing list" <linux-pm@lists.linux-foundation.org>
MIME-Version: 1.0
Subject: Re: Sleep problems with kernels >= 2.6.21 on powerpc
References: <6540c930708251937o2a9a23efv72a0f2b8947067bd@mail.gmail.com>
	<6bffcb0e0708261621q25316becqce7b3ae2176f45a8@mail.gmail.com>
	<20070827065246.GA21220@ime.usp.br>
In-Reply-To: <20070827065246.GA21220@ime.usp.br>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hallo!

I also have 800MHz iBook (2.2, 2 USB) and had the same problem with the=20
21.6.22 kernel a while ago and reverted back to 2.6.21. I'm not a kernel =

guy but I think I remember from kernel traces that it looked like (wise=20
chosen words ;-)) that the problems had something to do with=20
deactivating the firewire "subsystem".

I don't have traces at hand and due to lack of time cannot reproduce it=20
up to tomorrow. However this hint may speed up your analysis!

[rather long To-list, is everybody happy with this?]

--=20
Gru=DF...
        Tim

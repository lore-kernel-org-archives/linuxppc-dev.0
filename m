Message-ID: <395786BA.C2857491@claudio.ch>
Date: Mon, 26 Jun 2000 18:37:14 +0200
From: Claudio Nieder <private@claudio.ch>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: Kernel >=2.2.16 on Lombard
References: <39551A4B.2D488E6@claudio.ch>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

> linuxBenh, which identifies itself as version 2.2.16, will stop
> early during boot with the message:
>
>   pmac nvram is core99: 0
>   Don't know how to access NVRAM with 0 addresses.

Benjamin has modified his sources, so that this error will not happen
anymore. Thank you very much.

> linuxStable, which identifies itself as version 2.2.17pre3 will stop
> even earlier, after the line
>
>   booting...

linuxStable was upgraded to 2.2.17pre7. I tried to compile the
new source, and the resulting kernel works also. My thanks go to
whoever fixed that.
				claudio
--
Claudio Nieder, Kanalweg 1, CH-8610 Uster, Tel +41 79 357 6743
mailto:private@claudio.ch  http://www.claudio.ch  icq:42315212

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

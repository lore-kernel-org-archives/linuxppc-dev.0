Message-ID: <3BD6DCDB.D3F2C0F9@mvista.com>
Date: Wed, 24 Oct 2001 08:23:07 -0700
From: Armin Kuster <akuster@mvista.com>
MIME-Version: 1.0
To: David =?iso-8859-1?Q?M=FCller?= (ELSOFT AG) <d.mueller@elsoft.ch>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Registering RTC access methods in platform_init()
References: <3BD68B50.8090904@elsoft.ch>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


"David Müller (ELSOFT AG)" wrote:
>
> Hello
>
>
> I suppose the preferred way to solve this is to replace this whole init
> code by a call to a board specific init routine?
>
> Dave
>

Yes.. its seems to be the way they are moving, I ended up doing it for
the walnut a few months back.

before you know it there will be no ppc4xx_setup.c

-- armin

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

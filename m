From: Benjamin Herrenschmidt <bh40@calva.net>
To: Robert E Brose II <bob@kunk.jriver.com>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: 2.2.18 release version
Date: Tue, 12 Dec 2000 12:44:24 +0100
Message-Id: <19341106051608.18575@192.168.1.2>
In-Reply-To: <20001212061914.1845.qmail@kunk.jriver.com>
References: <20001212061914.1845.qmail@kunk.jriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>It does not however have Michel Lanners controlfb dma patch and
>memory detection fix. I suppose we'll have to hand patch that till
>2.4

I must have missed something... I never saw a "dma" patch for controlfb.
I did see a patch to make use of caching and this patch is in 2.4.

I didn't want to flood 2.2.18 with too much patches since there was
already a great bunch of them that went in and it needed to stabilize.
2.2.19 will have room for now stuffs however.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

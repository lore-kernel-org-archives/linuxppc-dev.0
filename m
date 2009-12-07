Return-Path: <risto.suominen@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1260151424.2249.1.camel@pasglop>
References: <46e1c7760912061436l76b895ebvf27407a08d41aa45@mail.gmail.com>
	<1260151424.2249.1.camel@pasglop>
Date: Mon, 7 Dec 2009 18:22:23 +0200
Message-ID: <46e1c7760912070822o79380f03i8047cac5d4b7ac7d@mail.gmail.com>
Subject: Re: MACE DMA problem on Powermac 7300
From: Risto Suominen <risto.suominen@gmail.com>
To: LinuxPPC-dev <LinuxPPC-dev@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi, Ben,

2009/12/7, Benjamin Herrenschmidt <benh@kernel.crashing.org>:
>
> Cache coherency bugs in the chipset or HW bugs in DBDMA, we've been
> seeing those on/off on those old apple chipsets...
>
> Try forcing a 32 bytes alignment ?
>
You're thinking of placing the DMA descriptors on different cache lines?

That's excactly what I did with de2104x. But it was easier, I think.
The chip handled its own DMA, and by writing a skip value to a
register... I don't know this GC DMA controller well enough and
haven't found the documentation either...

But I tried the de21041 board with unmodified driver on this 7300, and
it works. The problem was on a 5500.

Risto

From: benh@kernel.crashing.org
To: "Kevin B. Hendricks" <kevin.hendricks@sympatico.ca>,
	<linuxppc-dev@lists.linuxppc.org>
Cc: <yellowdog-devel@lists.terrasoftsolutions.com>
Subject: Re: problems with Sonnet Tempo ATA-100 - Is it supported?
Date: Tue, 11 Jun 2002 00:27:38 +0200
Message-Id: <20020610222738.21614@mailhost.mipsys.com>
In-Reply-To: <200206102232.16457.kevin.hendricks@sympatico.ca>
References: <200206102232.16457.kevin.hendricks@sympatico.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>I noticed that I/O ports are enable (not disabled).  I thought all I/O was
>MMIO (memory mapped) but I am unsure if this is the case.
>
>This card works fine under MacOSX, and Mac OS9 and I hoped PPC Linux which
>is why I bought it.
>
>Can someone give me some hints about where to look to fix this?  Is it just
>that the pdc202XX driver is not compatbile with ppc linux?
>
>Is anyone else using a Sonnet Tempo ATA100 pci card successfully with DMA
>and if so which driver?

The INs from bad ports mean the driver is trying to access ports that aren't
decoded by the card...

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

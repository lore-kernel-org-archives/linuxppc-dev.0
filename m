Subject: Re: Where to Put Ethernet MAC Addresses?
From: Gary Thomas <gary@mlbassoc.com>
To: Kent Borg <kentborg@borg.org>
Cc: linuxppc embedded <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <20031001153209.D688@borg.org>
References: <20031001153209.D688@borg.org>
Content-Type: text/plain
Message-Id: <1065037451.9737.585.camel@hermes>
Mime-Version: 1.0
Date: 01 Oct 2003 13:44:12 -0600
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, 2003-10-01 at 13:32, Kent Borg wrote:
> In boards where there is ethernet but no manufacturered in MAC address
> in the ethernet hardware, where does one get it?  Does this become a
> userland problem to be handled in init scripts?  It seems that
> ethernet initialization could also set the "manufacturer" MAC address,
> and it might be stored in flash next to the Linux image, or in some
> extra SPD bits, etc.
>
> What are the various right ways to do this?

Most embedded devices will handle this in the boot ROM.  When Linux
is booted, the hardware address can be passed in along with other
platform information like amount of memory installed, etc.

--
Gary Thomas <gary@mlbassoc.com>
MLB Associates


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

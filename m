Return-Path: <B04825@freescale.com>
From: Tabi Timur-B04825 <B04825@freescale.com>
To: David Daney <ddaney.cavm@gmail.com>
Subject: Re: [PATCH v6 0/3] netdev/of/phy: MDIO bus multiplexer support.
Date: Fri, 18 May 2012 21:42:34 +0000
Message-ID: <CAOZdJXWVCu+aNxcQRkcSSDsWWxnn8B9X5Y6=8oVgFwJ9SZTTGQ@mail.gmail.com>
References: <1336007799-31016-1-git-send-email-ddaney.cavm@gmail.com>
In-Reply-To: <1336007799-31016-1-git-send-email-ddaney.cavm@gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "devicetree-discuss@lists.ozlabs.org"
 <devicetree-discuss@lists.ozlabs.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 2, 2012 at 8:16 PM, David Daney <ddaney.cavm@gmail.com> wrote:
> From: David Daney <david.daney@cavium.com>
>
> This code has been working well for about six months on a couple of
> different configurations (boards), so I thought it would be a good
> time to send it out again, and I hope get it on the path towards
> merging.

David,

I'm trying to implement this feature on our boards, which don't use
GPIOs but rather a memory-mapped FPGA.  I control the mux by setting
some bits in one of the FPGA registers.

Do you have a real device tree I can use as an example?

I'm not sure what the "parent" MDIO bus node is supposed to represent.
 Is that that device that actually controls the muxing hardware, which
in our case would be the FPGA?

--=20
Timur Tabi
Linux kernel developer at Freescale=

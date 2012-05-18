Return-Path: <B04825@freescale.com>
Message-ID: <4FB6C886.3050105@freescale.com>
Date: Fri, 18 May 2012 17:09:10 -0500
From: Timur Tabi <b04825@freescale.com>
MIME-Version: 1.0
To: David Daney <ddaney.cavm@gmail.com>
Subject: Re: [PATCH v6 0/3] netdev/of/phy: MDIO bus multiplexer support.
References: <1336007799-31016-1-git-send-email-ddaney.cavm@gmail.com>
 <CAOZdJXWVCu+aNxcQRkcSSDsWWxnn8B9X5Y6=8oVgFwJ9SZTTGQ@mail.gmail.com>
 <4FB6C728.3090507@gmail.com>
In-Reply-To: <4FB6C728.3090507@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
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

David Daney wrote:
>> > I'm not sure what the "parent" MDIO bus node is supposed to represent.
>> >   Is that that device that actually controls the muxing hardware

> No.  It is the device that implements the master 802.3 clause {22,45} 
> MDIO Station Management (STA) protocol.

Ah, I think I get it.  It is *the* MDIO node that would normally exist if
muxing we're necessary on the board.  From the looks of it, that node
would look exactly the same if you didn't need muxing?

-- 
Timur Tabi
Linux kernel developer at Freescale

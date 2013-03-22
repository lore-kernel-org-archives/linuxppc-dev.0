Return-Path: <f.fainelli@gmail.com>
Sender: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <514C6B2D.5000100@openwrt.org>
Date: Fri, 22 Mar 2013 15:31:09 +0100
From: Florian Fainelli <florian@openwrt.org>
MIME-Version: 1.0
To: Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH 0/4 v3] mv643xx_eth: use mvmdio MDIO bus driver
References: <1363284515-9865-1-git-send-email-florian@openwrt.org>
 <1363959568-16976-1-git-send-email-florian@openwrt.org>
 <20130322141423.GJ13280@titan.lakedaemon.net> <514C69B7.8090106@openwrt.org>
 <20130322142924.GK13280@titan.lakedaemon.net>
In-Reply-To: <20130322142924.GK13280@titan.lakedaemon.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Andrew Lunn <andrew@lunn.ch>, Russell King <linux@arm.linux.org.uk>,
 linux-doc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>,
 netdev@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 linux-arm-kernel@lists.infradead.org, Rob Landley <rob@landley.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linuxppc-dev@lists.ozlabs.org,
 davem@davemloft.net, Lennert Buytenhek <buytenh@wantstofly.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Le 03/22/13 15:29, Jason Cooper a écrit :
>> Ok, thanks! Does that mean that you want these changes to go via
>> your tree? David initially applied my v2 of this patchset, and since
>> it thouches mostly ethernet driver stuff, I would rather make it go
>> via his tree if both of you agree.
>
> Yeah, I thought I should have reworded that after I hit send :)  I
> simply meant it applied cleanly against v3.9-rc3, booted, and worked.  I
> Acked it so David could take the whole series through his tree.  Sorry
> for the confusion.
>
> Now that I can build mv643xx_eth DT on top of this, I'll structure it so
> those changes go on top of yours (in David's tree) and try to avoid the
> external dependency for the DT bits going though arm-soc.

Sounds good! FYI, I am finishing up DSA Device Tree bindings so that we 
can finally get rid of board-specific Kirkwood files.
--
Florian

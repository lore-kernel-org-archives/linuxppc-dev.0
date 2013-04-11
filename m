Return-Path: <f.fainelli@gmail.com>
Sender: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <5166831E.9090105@openwrt.org>
Date: Thu, 11 Apr 2013 11:32:14 +0200
From: Florian Fainelli <florian@openwrt.org>
MIME-Version: 1.0
To: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH 0/2] net: mv643xx_eth: use managed clk and allocation
References: <1365672574-31123-1-git-send-email-sebastian.hesselbarth@gmail.com>
In-Reply-To: <1365672574-31123-1-git-send-email-sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>,
 Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
 linux-doc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>,
 Paul Mackerras <paulus@samba.org>, Rob Landley <rob@landley.net>,
 netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Lennert Buytenhek <buytenh@wantstofly.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Le 04/11/13 11:29, Sebastian Hesselbarth a écrit :
> With introduction of common clock framework and the ability to provide
> gated clocks, mv643xx_eth required calls to get and enable these clock
> gates on some platforms. Back then, common clock framework api wasn't
> safe for architectures without support for common clocks. This has
> changed now and there are also managed (devm_) counterparts for clock
> related functions.
>
> The second patch in this series, also converts kzalloc to devm_kzalloc
> where applicable.
>
> Both patches have been sent to the corresponding mailing lists as
> individual patches before. To get the order required to apply them right,
> this patch set combines both patches into one set.
>
> Sebastian Hesselbarth (2):
>    net: mv643xx_eth: add shared clk and cleanup existing clk handling
>    net: mv643xx_eth: use managed devm_kzalloc

Looks good, thanks Sebastian!

Acked-by: Florian Fainelli <florian@openwrt.org>
--
Florian

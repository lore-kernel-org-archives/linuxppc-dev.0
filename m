Return-Path: <f.fainelli@gmail.com>
Sender: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <51431935.6060407@openwrt.org>
Date: Fri, 15 Mar 2013 13:51:01 +0100
From: Florian Fainelli <florian@openwrt.org>
MIME-Version: 1.0
To: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 0/4] mv643xx_eth: use mvmdio MDIO bus driver
References: <1359473048-26551-1-git-send-email-florian@openwrt.org>
 <1363284515-9865-1-git-send-email-florian@openwrt.org>
 <20130315.085321.1047694772636447477.davem@davemloft.net>
In-Reply-To: <20130315.085321.1047694772636447477.davem@davemloft.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: thomas.petazzoni@free-electrons.com, andrew@lunn.ch, linux@arm.linux.org.uk,
 jason@lakedaemon.net, linux-doc@vger.kernel.org,
 devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 rob.herring@calxeda.com, netdev@vger.kernel.org, paulus@samba.org,
 linux-arm-kernel@lists.infradead.org, rob@landley.net,
 gregkh@linuxfoundation.org, linuxppc-dev@lists.ozlabs.org,
 buytenh@wantstofly.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Le 03/15/13 13:53, David Miller a écrit :
> From: Florian Fainelli <florian@openwrt.org>
> Date: Thu, 14 Mar 2013 19:08:31 +0100
>
>> This patch converts the mv643xx_eth driver to use the mvmdio MDIO bus driver
>> instead of rolling its own implementation. As a result, all users of this
>> mv643xx_eth driver are converted to register an "orion-mdio" platform_device.
>> The mvmdio driver is also updated to support an interrupt line which reports
>> SMI error/completion, and to allow traditionnal platform device registration
>> instead of just device tree.
>>
>> David, I think it makes sense for you to merge all of this, since we do
>> not want the architecture files to be desynchronized from the mv643xx_eth to
>> avoid runtime breakage. The potential for merge conflicts should be very small.
>
> All applied to net-next, thanks.
>

Oh woah that was fast, maybe too fast, I will submit a follow-up patch 
for patch 4 to address the issues I mentionned earlier.
--
Florian

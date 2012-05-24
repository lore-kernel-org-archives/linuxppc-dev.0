Return-Path: <ddaney.cavm@gmail.com>
Message-ID: <4FBE89D9.2090307@gmail.com>
Date: Thu, 24 May 2012 12:19:53 -0700
From: David Daney <ddaney.cavm@gmail.com>
MIME-Version: 1.0
To: Timur Tabi <b04825@freescale.com>
Subject: Re: [PATCH v6 0/3] netdev/of/phy: MDIO bus multiplexer support.
References: <1336007799-31016-1-git-send-email-ddaney.cavm@gmail.com>
 <CAOZdJXWVCu+aNxcQRkcSSDsWWxnn8B9X5Y6=8oVgFwJ9SZTTGQ@mail.gmail.com>
 <4FB6C728.3090507@gmail.com> <4FB6C886.3050105@freescale.com>
 <4FB6CBF1.40300@gmail.com> <4FBE7DD8.509@freescale.com>
 <4FBE82F2.6080100@gmail.com> <4FBE8605.2020507@freescale.com>
In-Reply-To: <4FBE8605.2020507@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

On 05/24/2012 12:03 PM, Timur Tabi wrote:
> David Daney wrote:
>
>> Well, the MDIO bus must have an associated device tree node.
>>
>> For my OCTEON code, the MDIO bus device is created as a result of the
>> call to of_platform_bus_probe(), which takes care of filling in all the
>> device tree nodes of the devices it finds and creates.
>
> Ok, let me give you some background.  We actually already have MDIO muxing
> code in-house, but it's different from yours.  So now I'm rewriting it to
> use your design instead.
>
> So our current code looks for "virtual MDIO nodes", and we call
> mdiobus_alloc() and then of_mdiobus_register().  I think this is what I'm
> missing now.
>
> I just don't know what to do next.

You will have to debug it and find out why the device match is failing, 
then fix it.

David Daney

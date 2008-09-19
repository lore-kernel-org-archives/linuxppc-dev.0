Return-Path: <pku.leo@gmail.com>
Message-ID: <2a27d3730809182326t2ee3f114hdaf844ead15acf7b@mail.gmail.com>
Date: Fri, 19 Sep 2008 14:26:57 +0800
From: "Li Yang" <leoli@freescale.com>
Sender: pku.leo@gmail.com
To: "Wolfgang Grandegger" <wg@grandegger.com>
Subject: Re: UCC GETH does not work on my MPC8360EA
In-Reply-To: <48D24CFA.3040604@grandegger.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
References: <48D0CB3C.7050708@grandegger.com>
	<113760FDF39C3E40AAB8DE6E6C64D0A7110901@zch01exm26.fsl.freescale.net>
	<48D24CFA.3040604@grandegger.com>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Sep 18, 2008 at 8:43 PM, Wolfgang Grandegger <wg@grandegger.com> wrote:
> Li Yang-R58472 wrote:
>>> -----Original Message-----
>>> From: linuxppc-dev-bounces+leoli=freescale.com@ozlabs.org
>>> [mailto:linuxppc-dev-bounces+leoli=freescale.com@ozlabs.org]
>>> On Behalf Of Wolfgang Grandegger
>>> Sent: Wednesday, September 17, 2008 5:18 PM
>>> To: linuxppc-dev
>>> Subject: UCC GETH does not work on my MPC8360EA
>>>
>>> Hello,
>>>
>>> I have a wired problems with my MPC8360EA using Linux
>>> 2.6.27-rc6. The UCC GEHT controller works fine with 100/Full
>>> but fails with 1000/Full.
>>> What I see is that the TX done interrupts come (ifconfig's TX
>>> packet counter goes up), but the messages does not show up on
>>> the wire. RX seems to work properly, though.
>>>
>>> Any idea what's going wrong? Does someone got it working with
>>> 1000/Full?
>>
>> This looks like an old problem that RGMII Tx shouldn't use internal
>> delay while Rx should use.  So try to use 'rgmii-rxid' as
>> phy-connection-type in device tree.  Also there should have been a fixup
>> in u-boot for this.  So update to use latest u-boot might fix your
>> problem.
>
> I do not have problems with U-Boot using 1000/full. The DTS property

I mean that the latest u-boot can fixup the phy-connection-type
automatically base on the chip revision.

- Leo

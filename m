Subject: Re: Strange code in head.S
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sylvain Munaut <tnt@246tNt.com>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <40487F63.6030703@246tNt.com>
References: <40487F63.6030703@246tNt.com>
Content-Type: text/plain
Message-Id: <1078531359.5698.134.camel@gaston>
Mime-Version: 1.0
Date: Sat, 06 Mar 2004 11:02:40 +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 2004-03-06 at 00:23, Sylvain Munaut wrote:
> Hello,
>
> While looking at head.S, I noticed that in the FTR Section
> CPU_FTR_HAS_HIGH_BATS, the register used during all the mtspr
> SPRN_DBATxx,r20 is r20.
> But shouldn't it be r10 ?
> In the 2.4 version it was r20 but for all the preceding code of
> clear_bat, it has been replaced with r10 but not in the FTR ...
>
> Maybe I'm wrong, I'm not working on an arch that uses it. It's just
> seems strange to me ...

Good catch !

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

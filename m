Message-ID: <3D6C1713.2050802@redswitch.com>
Date: Tue, 27 Aug 2002 17:19:31 -0700
From: "Xiaogeng (Shawn) Jin" <xjin@redswitch.com>
MIME-Version: 1.0
To: Ricardo Scop <scop@digitel.com.br>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: LXT972 FEC problem on MPC855
References: <20020826182707.BA14B11829@denx.denx.de> <3D6A9E57.1060308@redswitch.com> <02082619342400.01116@scop.digitel.com.br>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>>In the code which defines 'phy_info_lxt971', it says that somehow LXT971
>>tells me that the link is down when the first read after power-up. So
>>you have to read MII_REG_SR to set 'fep->phy_status' accordingly. But in
>>my case, the read action occurred too early to wait till the link is up.
>>So what I did is to delay 5s before reading MII_REG_SR during opening
>>FEC device. I guess it takes the link a while to autonegotiate the speed.
>
> Hmm. I suppose PHY should interrupt when link status change, and therefore
> phy_status would be updated accordingly. So, maybe you have a problem with
> your board's PHY interrupt signal.

Yeah, I think so. So I have to check whether the PHY interrupt is
enabled or not. Thanks for your thoughts.

- Shawn.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

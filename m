Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2250A67B5C
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 11 Aug 2006 22:37:58 +1000 (EST)
In-Reply-To: <OF8FBDC92D.1A664660-ON652571C7.003DFE8F-652571C7.003E60DC@lntinfotech.com>
References: <OF8FBDC92D.1A664660-ON652571C7.003DFE8F-652571C7.003E60DC@lntinfotech.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <CFF33627-951D-495D-8DBB-B0AC7F9D13D7@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Gianfar eth driver on 8540 ppc - for 2.4 and 2.6 : different
	outputs
Date: Fri, 11 Aug 2006 07:37:51 -0500
To: Prashant Yendigeri <Prashant.Yendigeri@lntinfotech.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Aug 11, 2006, at 6:21 AM, Prashant Yendigeri wrote:

>
> Hi,
>
> Downloaded 2.6.16.26 and booted up and got this :
>
> / # ifconfig eth0 172.28.8.254 up
> [   34.034596] 0:00 not found
> [   34.037330] eth0: Could not attach to PHY
> [   34.041809] 0:00 not found
> SIOCSIFFLAGS: No[   34.044526] eth0: Could not attach to PHY
>  such device
> SIOCSIFFLAGS: No such device
>
> I had enabled all the PHY devices in .config and also tried only  
> with Marvell phy enabled.


Are you doing this on a custom board?  If so what is the PHY address  
for the Marvell phy you are using?

- k

>
> Kernel boot messages :
> [    2.296555] Gianfar MII Bus: probed
> [    2.301789] eth0: Gianfar Ethernet Controller Version 1.2,  
> 00:01:af:07:9b:8a
>
> [    2.309039] eth0: Running with NAPI disabled
> [    2.313307] eth0: 64/64 RX/TX BD ring size
> [    2.318498] eth1: Gianfar Ethernet Controller Version 1.2,  
> 00:00:00:00:72:6f
>
> [    2.325738] eth1: Running with NAPI disabled
> [    2.330006] eth1: 64/64 RX/TX BD ring size
> [    2.335198] eth2: Gianfar Ethernet Controller Version 1.2, 6f: 
> 74:3d:2f:64:65
>
> [    2.342377] eth2: Running with NAPI disabled
> [    2.346662] eth2: 64/64 RX/TX BD ring size
> [    2.351586] Marvell 88E1101: Registered new driver
> [    2.357010] Davicom DM9161E: Registered new driver
> [    2.362443] Davicom DM9131: Registered new driver
> [    2.367775] Cicada Cis8204: Registered new driver
> [    2.373136] LXT970: Registered new driver
> [    2.377794] LXT971: Registered new driver
> [    2.382461] QS6612: Registered new driver
>
>
> Regards,
> Prashant
>
>
>
>
>
> Kumar Gala <galak@kernel.crashing.org>
> 08/11/2006 09:40 AM
>
> To
> Prashant Yendigeri <Prashant.Yendigeri@lntinfotech.com>
> cc
> linuxppc-embedded@ozlabs.org
> Subject
> Re: Gianfar eth driver on 8540 ppc - for 2.4 and 2.6 : different  
> outputs
>
>
>
>
>
>
> On Aug 10, 2006, at 6:18 AM, Prashant Yendigeri wrote:
>
> >
> > Hi,
> >
> > The gianfar driver of 2.6.12 and 2.4.20 give different outputs on
> > the same PPC 8540 board.
> >
> > What could be the reason ?
> >
> > Output on 2.4.20 :
> > /root # ifconfig eth0 172.28.8.254 up
> > eth0: PHY is Marvell 88E1011S (1410c62)
> > eth0: Auto-negotiation done
> > eth0: Half Duplex
> > eth0: Speed 10BT
> > eth0: Link is up
> >
> > Output on 2.6.12
> > / # ifconfig eth0 172.28.8.254 up
> >  eth0: PHY is Generic MII (ffffffff)
>
> It looks like your 2.6.12 kernel isn't handling the PHY correctly.
> I'd recommend upgrading to something newer which has the phylib
> (can't remember which 2.6 that went into).
>
> - kumar
>
> ______________________________________________________________________
>
>
> ______________________________________________________________________

Return-Path: <david.jander@protonic.nl>
From: David Jander <david.jander@protonic.nl>
To: Klaus Pedersen <kau@bang-olufsen.dk>
Subject: Re: MPC5121e, MBX driver, pvr.ko ...
Date: Mon, 16 Feb 2009 08:27:33 +0100
References: <OF4A842FE5.CCF31A69-ONC1257555.0030E2A2-C1257555.0031CBC3@bang-olufsen.dk>
In-Reply-To: <OF4A842FE5.CCF31A69-ONC1257555.0030E2A2-C1257555.0031CBC3@bang-olufsen.dk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200902160827.33338.david.jander@protonic.nl>
Cc: Linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 06 February 2009 10:03:55 Klaus Pedersen wrote:
> Hi David
>
> I'm also run on a custom board, and using the MBX.
>
> You need to get the device tree file right. You will see the MBX reserved
> the irq 66 in the boot printout.
> Instead of using insmod use modprobe. The are 2 versions of rc.pvr.

Thanks. I'll try that.
Two versions of rc.pvr? Why's that, and where is the other one?

> I a early thread about memcpy for G2/G3 cores, you mentioned that you will
> have a look at the init. of the dram controller and the prio-manager, did
> that give you anything??

Yes it did, and it's a long story, I havn't had persmission to talk about, 
sorry. I believe I can now say that there should be a new errata from 
Freescale explaining it all. As of now it's not on their web-site, but it 
should have been there since last week at least *grrr*.
Btw, it has nothing to do with the prio-manager or the DRAM controller 
whatsoever.

Best regards,

-- 
David Jander
Protonic Holland.

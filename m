Return-Path: <sr@denx.de>
Received: from mo-p05-ob.rzone.de (mo-p05-ob.rzone.de [81.169.146.180])
	by ozlabs.org (Postfix) with ESMTP id DFE4DDDF8C
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Apr 2009 03:18:12 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: AMCC 440EP phy detection
Date: Tue, 7 Apr 2009 19:18:01 +0200
References: <49DB8033.1090908@embeddedarm.com>
	<fa686aa40904071011n22084931wc8900606fd62f167@mail.gmail.com>
In-Reply-To: <fa686aa40904071011n22084931wc8900606fd62f167@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200904071918.01681.sr@denx.de>
Cc: Eddie Dawydiuk <eddie@embeddedarm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 07 April 2009, Grant Likely wrote:
> Phy address 0 is the broadcast address.  All phys will usually respond
> to address 0 accesses.

Not all. Some (e.g. LXT971) can be used at this address. But you're correct,  
it's definitely a bad idea to use 0 as an PHY address.

Not sure how the Micrel reacts here. The datasheet could help...

Best regards,
Stefan

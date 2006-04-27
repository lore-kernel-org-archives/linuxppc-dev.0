Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D922067A0E
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Apr 2006 05:54:59 +1000 (EST)
In-Reply-To: <20060427194522.6FA1B353A57@atlas.denx.de>
References: <20060427194522.6FA1B353A57@atlas.denx.de>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <9F5CC364-8FC8-48BA-8D12-E524815B6537@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: FT u-boot shim 
Date: Thu, 27 Apr 2006 14:54:54 -0500
To: Wolfgang Denk <wd@denx.de>
Cc: linuxppc-dev@ozlabs.org, U-Boot Users <u-boot-users@lists.sourceforge.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 27, 2006, at 2:45 PM, Wolfgang Denk wrote:

> In message <2CD98C5D- 
> E51C-49CA-9BDC-6FE4C1B67854@kernel.crashing.org> you wrote:
>>
>> We can do this w/o too much modification to what is happening in u-
>> boot today.  I'd probably like to keep the ability to build a dev
>> tree into the u-boot binary, but make the preferred means to pass a
>
> I don't like this, as it's a very Linux-centric view, but  U-Boot  is
> supposed to be OS unaware and independent.

Hmm, I guess.  There really isn't anything about the device tree that  
is Linux specific.  Other OSes could choice to use it.  But lets  
argue about that one once I've got the mechanism in which we pass the  
blob in via the bootm command.

The only difference I see would be that the address of the blob would  
be implicit if the blob was built into u-boot.  We would still use a  
passed in blob via the bootm command if given.

- kumar

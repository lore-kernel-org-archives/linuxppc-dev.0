Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F3C0EDDE1E
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  6 Sep 2007 00:11:50 +1000 (EST)
In-Reply-To: <F3D55679E1DCFF49A57570501B70475F070D83BB@CL5EXBE04.ad2.softcom.biz>
References: <F3D55679E1DCFF49A57570501B70475F070D83BB@CL5EXBE04.ad2.softcom.biz>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <718F9FE6-BBEA-4A80-9D7B-F2CE9A21A689@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: PCI:cannot allocate resource region 0 of device 0001:01:00.0?
Date: Wed, 5 Sep 2007 09:14:16 -0500
To: dnl <ssaravanan@mail2web.com>
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


On Sep 3, 2007, at 8:45 AM, dnl wrote:

>
> Hi all,
>
>  I using Montavista kernel for custom MPC8555CDS board and one PCI  
> slot on the Board.
>
>  When my kernel boots i am getting the following Messages :
>
>  PCI: Probing PCI hardware
>  PCI: Cannot allocate resource region 0 of device 0001:01:00.0
>  PCI: Cannot allocate resource region 1 of device 0001:01:00.0
>  PCI: Failed to allocate mem resource #1:80000000@0 for 0001:01:00.
>
>  please find attached Kernel boot messages and corresponding pci  
> directory after kernel boots.
> could anyone face similar problem?

You'll need to take up MV kernel issues up with MV.

- k

Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E2A4867B53
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 30 Aug 2006 23:31:51 +1000 (EST)
In-Reply-To: <405ECA8A30557F439A723E52D50838F9D8295F@ZMY16EXM66.ds.mot.com>
References: <405ECA8A30557F439A723E52D50838F9D8295F@ZMY16EXM66.ds.mot.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <E2E719E1-BC4F-4B31-86A2-2689F66CD045@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: How to turn off MMU in MPC8540
Date: Wed, 30 Aug 2006 08:31:45 -0500
To: Reddy Suneel-ASR125 <suneel.reddy@motorola.com>
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


On Aug 30, 2006, at 1:25 AM, Reddy Suneel-ASR125 wrote:

> Hi
>
> Can anyone know how to turn off MMU in MPC8540?

You can not turn the MMU off on the MPC8540 or any e500 based  
product.  You can emulate a 1:1 mapping if you so desire by  
preloading TLBs.

- kumar

Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4AC6ADDF44
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Dec 2008 06:36:06 +1100 (EST)
Message-Id: <1228A590-B809-4EBB-BC6F-05525220656A@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Frank Fan <linuxppcstudy@gmail.com>
In-Reply-To: <80872bab0812151058tdffd4b9ucd9031db21c9fc76@mail.gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: Need help to understand why kdump is for 64 bit PPC only
Date: Mon, 15 Dec 2008 13:35:55 -0600
References: <80872bab0812151058tdffd4b9ucd9031db21c9fc76@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 15, 2008, at 12:58 PM, Frank Fan wrote:

> Hello,
>
> I am working on a freescale MPC8572 CPU board and use 32 bit  
> Linux2.6.28.  When I enable 64 bit, it shows "kdump" in "kernel  
> options". Otherwise, "kdump" is disabled.
> Can someone give me some hint why kdump is for 64 bit PPC only?

Probably because no one has implemented or tested it on ppc32/8572.

- k

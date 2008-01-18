Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0571EDDF06
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 19 Jan 2008 02:52:26 +1100 (EST)
Message-Id: <F15F39D5-75B3-48C1-BD5F-FC2D28A0F117@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Subbu Linux <subbu.linux@gmail.com>
In-Reply-To: <f807f08a0801151216l59400ca0i746424a84befc7a8@mail.gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: Linux with e500 v2 core,
	can we support Ram base address starting at 0x1_0000_0000
Date: Fri, 18 Jan 2008 09:52:21 -0600
References: <f807f08a0801151216l59400ca0i746424a84befc7a8@mail.gmail.com>
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


On Jan 15, 2008, at 2:16 PM, Subbu Linux wrote:

> Hi
> I am currently working on MPC8548 core, would like to know wheather  
> current Linux with e500v2 core supporting Physical Address of RAM at  
> 0x1_0000_0000, I know in current linux with large Page table support  
> we can access devices at 0x1_0000_0000 for e500v2, but I wanted to  
> move RAM base address to 0x1_0000_0000, so that I can support larger  
> RAM. Can any body suggest me if their is any patch available for  
> this or is it possible to implement from scratch.

The HW supports this.  I don't believe there is any code that exists  
today that sets this all up.

- k

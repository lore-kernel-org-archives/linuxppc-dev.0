Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 04FCD2BD7B
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Sep 2004 07:31:28 +1000 (EST)
In-Reply-To: <Pine.LNX.4.60.0409171634340.5645@localhost.localdomain>
References: <Pine.LNX.4.60.0409171634340.5645@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <3280513A-08F1-11D9-829B-003065F9B7DC@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Fri, 17 Sep 2004 17:33:21 -0400
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Linuxppc-dev mailing list <linuxppc-dev@ozlabs.org>
Subject: Re: where to find explanation of CP "RISC controller trap
	registers"?
List-Id: "Linux on PowerPC \(Including Embedded\) Developers Mail List"
	<linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 17, 2004, at 4:42 PM, Robert P. J. Day wrote:

>   it all looks fairly straightforward, except in a couple cases where 
> the CP RISC controller trap registers are set to, allegedly, enable 
> the traps to get to [the patch].

They are not generally documented.  As I have said in the past, along 
with
the microcode is also documentation that explains how to use the patch.
The documentation states the order of initialization of various 
undocumented
CPM locations/registers and the values to write.  You just do it.


	-- Dan

Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 68AF3DE1A4
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Aug 2008 07:58:12 +1000 (EST)
Message-Id: <DAE7C7B4-CE5B-45EB-B3B4-E5491A843CD9@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: avorontsov@ru.mvista.com
In-Reply-To: <20080731210410.GA623@polina.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: libata badness
Date: Thu, 31 Jul 2008 16:58:05 -0500
References: <95646AC3-5385-4F59-8EBA-20F811168A87@kernel.crashing.org>
	<20080731210410.GA623@polina.dev.rtsoft.ru>
Cc: linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>,
	Linux Kernel list <linux-kernel@vger.kernel.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I figured out the issue.  Its related to the interrupt routing being  
conveyed to the code from the device tree.  We have a missing 'space'  
causing issues.

- k

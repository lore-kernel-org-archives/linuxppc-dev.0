Return-Path: <cml3227@eircom.net>
Received: from stanley (unknown [193.120.93.48])
	by ozlabs.org (Postfix) with ESMTP id 6713A2BD46
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 20 Oct 2004 01:26:37 +1000 (EST)
Received: from [192.168.1.160] (helo=eircom.net)
	by stanley with esmtp (Exim 4.30) id 1CJvsZ-0005pp-FL
	for linuxppc-embedded@ozlabs.org; Tue, 19 Oct 2004 16:26:27 +0100
Message-ID: <41753223.2030202@eircom.net>
Date: Tue, 19 Oct 2004 16:26:27 +0100
From: Conor McLoughlin <cml3227@eircom.net>
MIME-Version: 1.0
To: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
References: <1098072098.751.32.camel@nighteyes.localdomain>
	<41738D27.4060007@eircom.net>
	<BE328096-211A-11D9-8079-003065F9B7DC@embeddededge.com>
	<4174D1F4.2050506@eircom.net>
	<5925F5E8-21D9-11D9-A47E-003065F9B7DC@embeddededge.com>
In-Reply-To: <5925F5E8-21D9-11D9-A47E-003065F9B7DC@embeddededge.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: Re: Does kmalloc on MPC82xx work correctly with GFP_DMA?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Thanks to everyone who replied. I appreciate your time to help
educate me.

> It works because the 82xx is cache coherent.  The MMU mapping
> is irrelevant.  
That is the missing piece of the puzzle. I had worked with the 860
before and this was an issue. It hadn't occurred to me that the 82xx
was different.

> There is no bug here.  Just because people don't
> understand how something works doesn't mean there is a bug
> present.  
The reason I asked the question in the first place was because I didn't
understand how it could work.  I now understand it and can rest easier.

Thanks,
Conor

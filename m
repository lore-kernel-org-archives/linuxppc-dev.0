Return-Path: <sboyd@codeaurora.org>
Received: from wolverine02.qualcomm.com (wolverine02.qualcomm.com
	[199.106.114.251])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wolverine02.qualcomm.com",
	Issuer "VeriSign Class 3 Secure Server CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id D4055B6F14
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 15 Jan 2011 10:59:54 +1100 (EST)
Message-ID: <4D30E109.3050500@codeaurora.org>
Date: Fri, 14 Jan 2011 15:49:29 -0800
From: Stephen Boyd <sboyd@codeaurora.org>
MIME-Version: 1.0
To: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] drivers: char: hvc: add arm JTAG DCC console support
References: <1291145141-18301-1-git-send-email-dwalker@codeaurora.org>
	<4CF5DD63.40803@codeaurora.org>
	<1291229696.14404.39.camel@c-dwalke-linux.qualcomm.com>
	<4CF6AE04.6030201@codeaurora.org> <4CFE86AC.9010801@codeaurora.org>
	<20110114191956.GK4957@atomide.com>
In-Reply-To: <20110114191956.GK4957@atomide.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Randy Dunlap <randy.dunlap@oracle.com>,
	Daniel Walker <dwalker@codeaurora.org>, Mike Frysinger <vapier@gentoo.org>,
	Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nico@fluxnic.net>,
	linux-arm-msm@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>,
	linux-kernel@vger.kernel.org,
	FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
	Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/14/2011 11:19 AM, Tony Lindgren wrote:
> * Stephen Boyd <sboyd@codeaurora.org> [101207 11:00]:
>> On 12/01/2010 12:20 PM, Stephen Boyd wrote:
>>> Definitely for TX since it seems like a redundant loop, but I agree RX
>>> code has changed. Instead of
>>>
>>> If RX buffer full
>>> Poll for RX buffer full
>>> Read character from RX buffer
>>>
>>> we would have
>>>
>>> If RX buffer full
>>> Read character from RX buffer
>>>
>>> which doesn't seem all that different assuming the RX buffer doesn't go
>>> from full to empty between the If and Poll steps. Hopefully Tony knows more.
>>>
>>
>> Tony, any thoughts?
>
> Sorry for the delay, looks like I'm only 1 month behind with email..
> Sounds like it should work to me. I can try it out if you point me
> to a patch.

I think you acked the patches to make this change. You can test them out
by applying the "hvc_dcc cleanups and fixes" patches (Message-Id:
<1292875718-7980-1-git-send-email-sboyd@codeaurora.org>) on top of this
patch. They were sent as a reply to this thread.

Stephen

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.

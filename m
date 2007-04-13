Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 68FF2DDEBB
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Apr 2007 03:42:53 +1000 (EST)
In-Reply-To: <20070413123639.6485797b.kim.phillips@freescale.com>
References: <20070413012542.343eb848.kim.phillips@freescale.com>
	<B273DC06-E4DF-4FF5-88E8-2E6C634C98DA@kernel.crashing.org>
	<20070413123639.6485797b.kim.phillips@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <C04B1BEB-02F9-441A-9039-CE0E01E1F4B4@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 1/4 v2] powerpc: document max-speed and interface-type
	properties
Date: Fri, 13 Apr 2007 12:42:31 -0500
To: Kim Phillips <kim.phillips@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 13, 2007, at 12:36 PM, Kim Phillips wrote:

> On Fri, 13 Apr 2007 12:00:32 -0500
> Kumar Gala <galak@kernel.crashing.org> wrote:
>
>>
>> On Apr 13, 2007, at 1:25 AM, Kim Phillips wrote:
>>>> ---
>>> moved to recommended section (from required), removed sgmii, added
>>> rgmii-id.
>>
>> any reason to remove sgmii?  What is rgmii-id?
>>
> UCC doesn't support sgmii.

ahh.

> rgmii-id == RGMII with Internal Delay, see RGMII spec, or http:// 
> www.spinics.net/lists/netdev/msg28876.html

can we call this something like rgmii-internal-delay or something a  
bit more descriptive than -id (which makes one think identifier).

- k

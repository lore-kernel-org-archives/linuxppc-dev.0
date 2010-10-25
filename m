Return-Path: <micha@neli.hopto.org>
Received: from edu-smtp-02.edutel.nl (edu-smtp-02.edutel.nl [88.159.1.176])
	by ozlabs.org (Postfix) with ESMTP id 46E5FB70B8
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 26 Oct 2010 03:13:35 +1100 (EST)
Message-ID: <4CC5ACAB.7070309@neli.hopto.org>
Date: Mon, 25 Oct 2010 18:13:31 +0200
From: Micha Nelissen <micha@neli.hopto.org>
MIME-Version: 1.0
To: "Bounine, Alexandre" <Alexandre.Bounine@idt.com>
Subject: Re: [PATCH -mm 0/2] RapidIO: Changes to handling of RIO switches
References: <1287688250-14226-1-git-send-email-alexandre.bounine@idt.com>
	<4CC0AD74.8070800@neli.hopto.org>
	<0CE8B6BE3C4AD74AB97D9D29BD24E55201445906@CORPEXCH1.na.ads.idt.com>
	<4CC1D7DE.7060405@neli.hopto.org>
	<0CE8B6BE3C4AD74AB97D9D29BD24E55201445A6B@CORPEXCH1.na.ads.idt.com>
	<4CC20923.8050400@neli.hopto.org>
	<0CE8B6BE3C4AD74AB97D9D29BD24E55201445BA4@CORPEXCH1.na.ads.idt.com>
In-Reply-To: <0CE8B6BE3C4AD74AB97D9D29BD24E55201445BA4@CORPEXCH1.na.ads.idt.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linux-kernel@vger.kernel.org, Thomas Moll <thomas.moll@sysgo.com>,
	akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Bounine, Alexandre wrote:
> Micha Nelissen <micha@neli.hopto.org> wrote:
>>> rid of rswitch->switchid and use component_tag directly for
> switches).
>> I still prefer the destid as the single identification id.
> 
> In your patch you allocate individual destid for switches. This method
> has two problems:
> 1. The destid for the switch needs an additional mechanism to share it
> among processors in the RIO network,

? See comment for 2)

> 2. It takes ID value away from the pool of available IDs, what will

It does not take an ID away, it shares it with a connected endpoint to 
that switch. The tag uses one extra bit to identify the device as a 
switch instead of an endpoint. This provides the information to 
unambiguously identify a switch from an endpoint.

Micha

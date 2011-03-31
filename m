Return-Path: <leon.woestenberg@gmail.com>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id ADE84B6EEC
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 31 Mar 2011 22:44:11 +1100 (EST)
Received: by bwz10 with SMTP id 10so1699157bwz.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 31 Mar 2011 04:44:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <38B7F1DC-21FC-4723-AF41-E66E04DF0B1F@kernel.crashing.org>
References: <1301028465-3897-1-git-send-email-prabhakar@freescale.com>
	<38B7F1DC-21FC-4723-AF41-E66E04DF0B1F@kernel.crashing.org>
Date: Thu, 31 Mar 2011 13:44:06 +0200
Message-ID: <AANLkTi=HSU42BJCVY+GoRE1WzU8auUK9vRyz8YrNZ8B_@mail.gmail.com>
Subject: Re: [PATCH] powerpc/dts:Update PCIe memory maps to match u-boot of
	Px020RDB
From: Leon Woestenberg <leon.woestenberg@gmail.com>
To: Kumar Gala <galak@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: meet2prabhu@gmail.com, linuxppc-dev@lists.ozlabs.org,
	Prabhakar Kushwaha <prabhakar@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Prabhakar, Kumar,

(I missed the original post, due to temporarely being unsubscribed, I
am responding to Kumar's reply).

On Thu, Mar 31, 2011 at 10:22 AM, Kumar Gala <galak@kernel.crashing.org> wrote:
> On Mar 24, 2011, at 11:47 PM, Prabhakar Kushwaha wrote:
>
>> PCIe memory address space is 1:1 mapped with u-boot.
>>
>> Update dts of Px020RDB i.e. P1020RDB and P2020RDB to match the address map
>> changes in u-boot.
>>
Does this mean u-boot and Linux versions should be selectively matched, or not?

What commit in u-boot does this apply to?

Regards,
-- 
Leon

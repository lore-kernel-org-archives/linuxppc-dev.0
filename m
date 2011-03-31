Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 17EFCB6EDF
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  1 Apr 2011 08:26:24 +1100 (EST)
Subject: Re: [PATCH] powerpc/dts:Update PCIe memory maps to match u-boot of
	Px020RDB
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <AANLkTi=HSU42BJCVY+GoRE1WzU8auUK9vRyz8YrNZ8B_@mail.gmail.com>
Date: Thu, 31 Mar 2011 16:26:13 -0500
Message-Id: <4BF02342-D081-4FB3-BBD0-C582E53D9C73@kernel.crashing.org>
References: <1301028465-3897-1-git-send-email-prabhakar@freescale.com>
	<38B7F1DC-21FC-4723-AF41-E66E04DF0B1F@kernel.crashing.org>
	<AANLkTi=HSU42BJCVY+GoRE1WzU8auUK9vRyz8YrNZ8B_@mail.gmail.com>
To: Leon Woestenberg <leon.woestenberg@gmail.com>
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


On Mar 31, 2011, at 6:44 AM, Leon Woestenberg wrote:

> Hello Prabhakar, Kumar,
>=20
> (I missed the original post, due to temporarely being unsubscribed, I
> am responding to Kumar's reply).
>=20
> On Thu, Mar 31, 2011 at 10:22 AM, Kumar Gala =
<galak@kernel.crashing.org> wrote:
>> On Mar 24, 2011, at 11:47 PM, Prabhakar Kushwaha wrote:
>>=20
>>> PCIe memory address space is 1:1 mapped with u-boot.
>>>=20
>>> Update dts of Px020RDB i.e. P1020RDB and P2020RDB to match the =
address map
>>> changes in u-boot.
>>>=20
> Does this mean u-boot and Linux versions should be selectively =
matched, or not?

=46rom time to time they have to be.  PCIe was broken between u-boot & =
linux on these boards.

> What commit in u-boot does this apply to?

=
http://git.denx.de/?p=3Du-boot.git;a=3Dcommit;h=3Db0c5ceb305054aadf2f810b0=
b7bfcc94926b78ad

- k=

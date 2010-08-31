Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 59601B7121
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Aug 2010 14:37:18 +1000 (EST)
Subject: Re: [PATCH 1/3] PPC: s/mtmsrd/MTMSR in ldstfp.S
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20100830224932.21b5d7f2@lappy.seanm.ca>
Date: Mon, 30 Aug 2010 23:37:10 -0500
Message-Id: <7D9A40B6-0A34-41B3-A1D6-0B5E15507B9E@kernel.crashing.org>
References: <1283220922-20369-1-git-send-email-agraf@suse.de>
	<1283220922-20369-2-git-send-email-agraf@suse.de>
	<20100830224932.21b5d7f2@lappy.seanm.ca>
To: Sean MacLennan <smaclennan@pikatech.com>
Cc: Linuxppc-dev <linuxppc-dev@ozlabs.org>, Alexander Graf <agraf@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Aug 30, 2010, at 9:49 PM, Sean MacLennan wrote:

> On Tue, 31 Aug 2010 04:15:20 +0200
> Alexander Graf <agraf@suse.de> wrote:
>=20
>> Commit 0016a4cf introduced a lot of mtmsrd's that were plainly
>> written out. These failed to compile on my e500v2 system, so let's
>> better use the macro that is around just for that purpose.
>=20
> I sent in the same patch ;)

I'm surprised we are compiling this code on e500v2.  We are probably =
missing some CONFIG_PPC_FPU in there as well.

- k=

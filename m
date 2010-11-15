Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9A74CB711E
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 16 Nov 2010 04:43:31 +1100 (EST)
Subject: Re: [PATCH v2] fsldma: add support to 36-bit physical address
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <AANLkTin8+13mr-tV-2iCG+zGRfF6xZ23cN+=44dsaQor@mail.gmail.com>
Date: Mon, 15 Nov 2010 11:43:12 -0600
Message-Id: <72D46FED-AFC8-4599-ADB0-2A2B634CCE48@kernel.crashing.org>
References: <1289477789-10651-1-git-send-email-leoli@freescale.com>
	<54AAF9B7-9533-45B8-9C49-A964203AF707@kernel.crashing.org>
	<AANLkTi=1nutREorMFY2VJyUYQD0SHfiSeskw-u22P+R-@mail.gmail.com>
	<3B38AD35-39A2-4A54-8109-65D6DE436227@kernel.crashing.org>
	<AANLkTin8+13mr-tV-2iCG+zGRfF6xZ23cN+=44dsaQor@mail.gmail.com>
To: Timur Tabi <timur.tabi@gmail.com>
Cc: dan.j.williams@intel.com, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Nov 15, 2010, at 10:13 AM, Timur Tabi wrote:

> On Mon, Nov 15, 2010 at 9:16 AM, Kumar Gala =
<galak@kernel.crashing.org> wrote:
>=20
>> The programming model (if you look at the free-space in the registers =
and data structures) supports a 64-bit address.  I'm trying to avoid =
changing the driver in the future if we have >36-bit.  However this is =
such a minor worry that I'll stop and just ack the patch as is.
>=20
> I must still be missing something.  I'm looking at the description of
> the SATR register in the MPC8572 RM, and it shows this:
>=20
> 0 - 3 |   4 - 5   |     6     |   7  |   8 - 11  |   12 - 15  | 16-21 =
| 22-31
> ---  | STFLOWLVL | SPCIORDER | SSME | STRANSINT | SREADTTYPE |  ---  | =
 ESAD
>=20
> The most that we can extend ESAD to is 16 bits, for a total of a
> 48-bit physical address.  Where are the other 16 bits supposed to go?

I was looking at the link addresses.  I stand corrected so our max is =
48-bits.

- k=

Return-Path: <kaloz@openwrt.org>
Received: from arrakis.dune.hu (arrakis.dune.hu [78.24.191.176])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B9B0FB7D13
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Mar 2010 09:03:56 +1100 (EST)
Content-Type: text/plain; charset=us-ascii; format=flowed; delsp=yes
To: "Josh Boyer" <jwboyer@linux.vnet.ibm.com>, "David Goodenough"
	<david.goodenough@btconnect.com>
Subject: Re: Can the OpenRB board descriptions be merged into the mainline
	kernel?
References: <201003161223.19238.david.goodenough@btconnect.com>
	<20100316143903.GK8963@zod.rchland.ibm.com>
Date: Tue, 16 Mar 2010 22:58:00 +0100
MIME-Version: 1.0
From: "Imre Kaloz" <kaloz@openwrt.org>
Message-ID: <op.u9okmyyw2s3iss@ecaz>
In-Reply-To: <20100316143903.GK8963@zod.rchland.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 16 Mar 2010 15:39:03 +0100, Josh Boyer <jwboyer@linux.vnet.ibm.com> wrote:

> On Tue, Mar 16, 2010 at 12:23:19PM +0000, David Goodenough wrote:
>> OpenWRT has some fixes which adds the board descriptions for the OpenRB
>> (ppc504 based boards).  Is there any reason why these should not be
>
> ppc504?  I've not heard of that one.  Is that a typo for 405?

Typo.

>> merged into the mainline kernel?  The fixes are all licences GPL2.
>>
>> If not do you want the original authors to submit them, or shall I take the
>> OpenWRT specific bits out and post them here?
>
> What exactly do you mean by "board description"?

These are part of the patches I've told you about over IRC. The port uses the
ppc40x_simple stuff with cuImage wrapper. It also has a CF connector, so
that driver needs to be merged, too..

I'll submit everything when I'm a bit better.. Spent the last two weeks in bed :/


Imre

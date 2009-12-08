Return-Path: <tmarri@amcc.com>
Received: from sdcmail02.amcc.com (sdcmail02.amcc.com [198.137.200.90])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "Messaging Gateway Appliance Demo Cert",
	Issuer "Messaging Gateway Appliance Demo Cert" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id F158CB6F19
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  8 Dec 2009 12:41:37 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: patch status
Date: Mon, 7 Dec 2009 17:41:35 -0800
Message-ID: <AC5E1C3367E37D44970B81A6ADD1DA2C0872CF47@SDCEXCHANGE01.ad.amcc.com>
In-Reply-To: <20091208005257.GL2937@zod.rchland.ibm.com>
References: <AC5E1C3367E37D44970B81A6ADD1DA2C0872CE8B@SDCEXCHANGE01.ad.amcc.com>
	<20091208005257.GL2937@zod.rchland.ibm.com>
From: "Tirumala Reddy Marri" <tmarri@amcc.com>
To: "Josh Boyer" <jwboyer@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Josh,
  Sorry for my ignorance that I did not copy you first. From now on I
will make sure you are cc'ed .  I will send you the copy of user manual
which is available on external website.=20

  Should I send new patch with what is tested with this change or is it
enough to write in email ?

Regards,
Marri

-----Original Message-----
From: Josh Boyer [mailto:jwboyer@linux.vnet.ibm.com]=20
Sent: Monday, December 07, 2009 4:53 PM
To: Tirumala Reddy Marri
Cc: benh@kernel.crashing.org; linuxppc-dev@lists.ozlabs.org
Subject: Re: patch status

On Mon, Dec 07, 2009 at 02:01:58PM -0800, Tirumala Reddy Marri wrote:
>Hi Ben,
>
> Did you get the chance to review the patch I sent it on Dec-1 2009
>
>=20
>
>http://lists.ozlabs.org/pipermail/linuxppc-dev/2009-December/078436.htm
l

Ben has to review lots of patches.  Please be patient.  Also, your patch
is
tracked via patchwork here:

http://patchwork.ozlabs.org/patch/39865/

so you can see the state as it progresses.

Further, it would have been helpful to CC the maintainer of the 4xx
sub-arch
(me) since it impacts that platform and you could have gotten some
review more
quickly.  I didn't notice it until this afternoon.

Lastly, your patch has lots of magical values in it.  While I have no
doubt
they are correct, I can't find any documentation for 460SX on the AMCC
website
aside from some small product briefs.  Perhaps I've overlooked the CPU
manual,
but since I don't have such a board or the manual for it, it would be
nice to
know what kind of testing has been done with this patch.  A simple
statement
such as "tested on kernel <version> with a <network, raid, whatever>
pci-e
card successfully" would go a long way.

This is not a rant or complaint about the code.  Just a reminder that
the
community doesn't always move at the pace we would all like :).  I'll
try and
look over the patch more carefully tomorrow.

josh

Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EB063B7135
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  2 Oct 2010 06:52:08 +1000 (EST)
Subject: Re: Introduce support for little endian PowerPC
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <BBD78246-343E-4A96-9E55-3E40AD628C0B@kernel.crashing.org>
References: <1285916771-18033-1-git-send-email-imunsie@au1.ibm.com>
	<2C5357FA-F87F-457E-B5C1-0DCC5A842DE7@kernel.crashing.org>
	<AANLkTinSDMvBb7rnnfwYMkEVOgDUqRetZg86rh-UmSAg@mail.gmail.com>
	<1285935283.2463.78.camel@pasglop>
	<BBD78246-343E-4A96-9E55-3E40AD628C0B@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 02 Oct 2010 06:51:55 +1000
Message-ID: <1285966315.2463.141.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org,
	Ian Munsie <imunsie@au1.ibm.com>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2010-10-01 at 12:59 -0500, Kumar Gala wrote:
> I'm not against it, and I agree some of the patches seem like good
> clean up.  I'm concerned about this bit rotting pretty quickly.

Maybe. Most of it doesn't seem to be that bit-rottable.

The changes to the asm stuff in misc_32.S for example are functions we
never ever touch once written (libgcc replacements) so I don't see them
rotting more with LE support than they did with BE :-)

What might rot is that we might introduce new LE breakage, true, and I
suppose it's going to be to some extent my job to at least every now and
then shoot that thing on a 44x to see if it still flies.

Cheers,
Ben.

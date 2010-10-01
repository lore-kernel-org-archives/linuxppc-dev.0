Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A4232B70FB
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  1 Oct 2010 22:15:41 +1000 (EST)
Subject: Re: Introduce support for little endian PowerPC
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gary Thomas <gary@mlbassoc.com>
In-Reply-To: <4CA5CC3C.6020006@mlbassoc.com>
References: <1285916771-18033-1-git-send-email-imunsie@au1.ibm.com>
	<2C5357FA-F87F-457E-B5C1-0DCC5A842DE7@kernel.crashing.org>
	<AANLkTinSDMvBb7rnnfwYMkEVOgDUqRetZg86rh-UmSAg@mail.gmail.com>
	<4CA5CC3C.6020006@mlbassoc.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 01 Oct 2010 22:15:29 +1000
Message-ID: <1285935329.2463.79.camel@pasglop>
Mime-Version: 1.0
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, Ian Munsie <imunsie@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2010-10-01 at 05:55 -0600, Gary Thomas wrote:
> On 10/01/2010 05:30 AM, Josh Boyer wrote:
> > On Fri, Oct 1, 2010 at 5:02 AM, Kumar Gala<galak@kernel.crashing.org>  wrote:
> >>
> >> On Oct 1, 2010, at 2:05 AM, Ian Munsie wrote:
> >>
> >>> Some PowerPC processors can be run in either big or little endian modes, some
> >>> others can map selected pages of memory as little endian, which allows the same
> >>> thing. Until now we have only supported the default big endian mode in Linux.
> >>> This patch set introduces little endian support for the 44x family of PowerPC
> >>> processors.
> >>
> >>  From a community aspect is anyone actually going to use this?  Is this going to be the equivalent of voyager on x86?  I've got nothing against some of the endian clean ups this introduces.  However the changes to misc_32.S are a bit ugly from a readability point of view.  Just seems like this is likely to bit-rot pretty quickly.
> >
> > I'm with Kumar on this one.  Why would we want to support this?  I
> > can't say I would be very willing to help anyone run in LE mode, let
> > alone have it randomly selectable.
> 
> Indeed, I thought we had killed that Windows-NT dog ~15 years ago :-)

Actually this has more to do with having to deal with code written for
ARM LE :-)

Cheers,
Ben.

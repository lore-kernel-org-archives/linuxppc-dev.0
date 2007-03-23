Return-Path: <jwboyer@jdub.homelinux.org>
Received: from jdub.homelinux.org (71-36-216-66.roch.qwest.net [71.36.216.66])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6C9EEDE024
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 23 Mar 2007 21:43:51 +1100 (EST)
Subject: Re: AVNET 440GX board
From: Josh Boyer <jwboyer@jdub.homelinux.org>
To: Stefan Roese <sr@denx.de>
In-Reply-To: <200703230722.25498.sr@denx.de>
References: <393e3a4b0703221234n20eee581g6cbf9af9be2c5ebb@mail.gmail.com>
	<200703230722.25498.sr@denx.de>
Content-Type: text/plain
Date: Fri, 23 Mar 2007 05:40:18 -0500
Message-Id: <1174646418.2977.84.camel@vader.jdub.homelinux.org>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, 2007-03-23 at 07:22 +0100, Stefan Roese wrote:
> Ken,
> 
> On Thursday 22 March 2007 20:34, Ken Sakurai wrote:
> > I'm trying to boot Linux on  AVNET 440gx eval board but no luck so far.
> > What I did are that I downloaded a plain 2.6.20 kernel from kernel.org,
> > configured with 440GX, OCOTEA target (I'm not sure OCOTEA is correct
> > target),
> 
> I don't know the AVNET 440GX eval board. Is it _identical_ to the IBM/AMCC 
> Ocotea? If not you will most likely have no luck with this image. You will 
> have to port Linux to this special board.

No, it's not identical.  We had one of these boards at one point and it
was a pain in the arse.

josh

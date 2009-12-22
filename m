Return-Path: <roman.fietze@telemotive.de>
Received: from coyote.quickmin.net (coyote.quickmin.net [217.14.112.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.quickmin.de", Issuer "smtp.quickmin.de" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 9361EB6F04
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 22 Dec 2009 17:55:18 +1100 (EST)
Received: from rfietze.mit.telemotive.de (rfietze.mit.telemotive.de
	[192.168.5.33])
	by alderan.mit.telemotive.de (Postfix) with ESMTP id 74D1AC0A25
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 22 Dec 2009 07:55:10 +0100 (CET)
From: Roman Fietze <roman.fietze@telemotive.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 0/13] MPC5200B LocalPlus Platform Driver Changes
References: <200912081339.50722.roman.fietze@telemotive.de>
	<200912171355.34694.roman.fietze@telemotive.de>
	<fa686aa40912211611i2469b15p175511fd7ead4d49@mail.gmail.com>
In-Reply-To: <fa686aa40912211611i2469b15p175511fd7ead4d49@mail.gmail.com>
MIME-Version: 1.0
Message-ID: <200912220755.09756.roman.fietze@telemotive.de>
Date: Tue, 22 Dec 2009 07:55:09 +0100
Content-Type: Text/Plain;
  charset="iso-8859-1"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Grant,

On Tuesday 22 December 2009 01:11:30 Grant Likely wrote:

> "Access Forbidden!"

git-fetch should have worked. It's a git tree prepared using
git-update-server-info.

> It is easier for me though if you post them to the list. Then I can
> just hit "reply to all" and make comments on the code.

Ok, I'll do so. I hope I've understood what
http://www.kernel.org/pub/linux/docs/lkml/ says about creating
suitable patches for mailing lists.


Patch description:

This is a series of patches on top of the benh next branch modifying
the platform LocalPlus driver for the MPC5200B. This includes
formatting changes in the first step, switching to a structure
describing the SCLPC registers, making DMA work, making unloading the
module work and so on.


Roman

=2D-=20
Roman Fietze                Telemotive AG B=FCro M=FChlhausen
Breitwiesen                              73347 M=FChlhausen
Tel.: +49(0)7335/18493-45        http://www.telemotive.de

Return-Path: <roman.fietze@telemotive.de>
Received: from coyote.quickmin.net (coyote.quickmin.net [217.14.112.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.quickmin.de", Issuer "smtp.quickmin.de" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id DB93AB7080
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 15 Apr 2010 17:21:54 +1000 (EST)
Received: from rfietze.mit.telemotive.de (rfietze.mit.telemotive.de
	[192.168.5.33])
	by alderan.mit.telemotive.de (Postfix) with ESMTP id 85009CA686
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 15 Apr 2010 09:21:47 +0200 (CEST)
From: Roman Fietze <roman.fietze@telemotive.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: Xorg on Fujitsu "Lime" with MPC5200b?
References: <4BC682DC.1050200@billgatliff.com>
In-Reply-To: <4BC682DC.1050200@billgatliff.com>
MIME-Version: 1.0
Message-ID: <201004150921.47268.roman.fietze@telemotive.de>
Date: Thu, 15 Apr 2010 09:21:46 +0200
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

Hallo Bill,

On Thursday 15 April 2010 05:07:08 Bill Gatliff wrote:

> Actually, I *have* Debian squeeze's xorg running on the platform just
> fine, with a 2.6.34-rc1 kernel (kernel.org).  Problem is, every single
> diagonal line is very blocky--- not smooth at all.

I'm 95% sure it's an endianess problem, on our boards we had to modify
the X11 driver. What I did was swapping bytes when updating the device
from the shadowfb inside programs/Xserver/miext/shadow/shpacked.c


Roman

=2D-=20
Roman Fietze                Telemotive AG B=FCro M=FChlhausen
Breitwiesen                              73347 M=FChlhausen
Tel.: +49(0)7335/18493-45        http://www.telemotive.de

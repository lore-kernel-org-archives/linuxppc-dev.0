Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id A8278B6F34
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 21 Aug 2009 02:18:31 +1000 (EST)
Received: from SG2EHSOBE005.bigfish.com (sg2ehsobe005.messaging.microsoft.com
	[207.46.51.79]) by ozlabs.org (Postfix) with ESMTP id 5E9A8DDD04
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Aug 2009 02:18:31 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: RE: [PATCH] [V3] net: add Xilinx emac lite device driver
Date: Thu, 20 Aug 2009 09:02:07 -0700
In-Reply-To: <20090820094956.02DFC45004F@mail96-dub.bigfish.com>
References: <20090820094956.02DFC45004F@mail96-dub.bigfish.com>
From: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
To: "John Linn" <john.linn@xilinx.com>, <netdev@vger.kernel.org>,
	<linuxppc-dev@ozlabs.org>, <davem@davemloft.net>, <jgarzik@pobox.com>
Message-ID: <20090820160356.F1A03340054@mail79-sin.bigfish.com>
Cc: John Linn <linnj@xilinx.com>, Sadanand Mutyala <sadanan@xilinx.com>,
	John Williams <john.williams@petalogix.com>,
	Michal Simek <michal.simek@petalogix.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


John,

I just got a chance to browse this...  Do you want to put in the
stripped device names?

.compatible =3D "xlnx,xps-ethernetlite-2", etc...

Steve

This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.

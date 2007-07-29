Return-Path: <rene@exactcode.de>
Received: from mx01.qsc.de (mx01.qsc.de [213.148.129.14])
	by ozlabs.org (Postfix) with ESMTP id 40A0DDDD08
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Jul 2007 03:24:01 +1000 (EST)
Received: from exactcode.de (port-212-202-170-151.dynamic.qsc.de
	[212.202.170.151]) by mx01.qsc.de (Postfix) with ESMTP id 0EB2FC7921
	for <linuxppc-dev@ozlabs.org>; Sun, 29 Jul 2007 19:04:59 +0200 (CEST)
Received: from port-83-236-211-226.static.qsc.de ([83.236.211.226]
	helo=[192.168.2.172])
	by exactcode.de with esmtpsa (TLSv1:AES256-SHA:256) (Exim 4.54)
	id 1IFCCV-0004iS-K8
	for linuxppc-dev@ozlabs.org; Sun, 29 Jul 2007 17:05:05 +0000
From: =?iso-8859-1?q?Ren=E9_Rebe?= <rene@exactcode.de>
To: linuxppc-dev@ozlabs.org
Subject: Using video memory on PS3 e.g. as SWAP?
Date: Sun, 29 Jul 2007 19:04:55 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200707291904.55700.rene@exactcode.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi all,

looking at the PS3 as one of the few PowerPC workstation options the RAM
is obviously quite limitted with just 256MB. I wonder if the 256MB of
video memory can be mapped or at least be used as super-fast SWAP?

Or are there news regarding accessing the video chip from Linux beside
the unaccelerated frame-buffer?

Regards,

=2D-=20
  Ren=E9 Rebe - ExactCODE GmbH - Europe, Germany, Berlin
  http://exactcode.de | http://t2-project.org | http://rene.rebe.name

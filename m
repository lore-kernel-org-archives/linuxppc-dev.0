Return-Path: <andreas_schmidt@ifm-electronic.com>
Received: from mail1.ifm-electronic.com (mail1.ifm-electronic.com
	[62.180.229.59]) by ozlabs.org (Postfix) with ESMTP id 0562D67B6E
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 29 Jun 2005 18:18:12 +1000 (EST)
To: grave@ipno.in2p3.fr
Message-ID: <OFA98242DA.3B8BFBE9-ONC125702F.002D06C8-C125702F.002D7592@ifm-electronic.com>
From: andreas_schmidt@ifm-electronic.com
Date: Wed, 29 Jun 2005 10:16:33 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: ppc405 kernel debugging
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

hi

You can debug it with static variables. After compile the kernel, you can see the address
of this static variable in System.map and when the kernel runs you can see the value of
this variable in xmd debug tool.

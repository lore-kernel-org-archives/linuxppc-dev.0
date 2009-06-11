Return-Path: <ncase@xes-inc.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 9FAC6B7136
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 12 Jun 2009 05:43:31 +1000 (EST)
Received: from xes-mad.com (xes-mad.com [216.165.139.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C2C09DDD01
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jun 2009 05:43:28 +1000 (EST)
From: Nate Case <ncase@xes-inc.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH v3 -next 0/0] powerpc/85xx: Support for X-ES MPC85xx boards
Date: Thu, 11 Jun 2009 14:42:57 -0500
Message-Id: <1244749381-17429-1-git-send-email-ncase@xes-inc.com>
Cc: linuxppc-dev@ozlabs.org, Nate Case <ncase@xes-inc.com>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

This is v3 of the "Add support for X-ES MPC85xx boards" patch submitted
earlier.  This time it's split up as Kumar requested:

 [1/4] powerpc/85xx: Add platform support for X-ES MPC85xx boards
 [2/4] powerpc/85xx: Add dts files for X-ES MPC85xx boards
 [3/4] powerpc/85xx: Add defconfig for X-ES MPC85xx boards
 [4/4] powerpc/bootwrapper: Custom build options for XPedite52xx targets

This shouldn't be too invasive since the bulk of the changes are new
files.  This version should address the items brought up by Kumar and
David Gibson.

--
Nate Case <ncase@xes-inc.com>

Return-Path: <miltonm@sullivan.realtime.net>
Received: from sullivan.realtime.net (sullivan.realtime.net [205.238.132.226])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AD691DE033
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Mar 2007 02:03:05 +1100 (EST)
Received: from sullivan.realtime.net (localhost [127.0.0.1])
	by sullivan.realtime.net (8.13.1/8.9.3) with ESMTP id l2LF32IK008516
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Mar 2007 09:03:02 -0600 (CST)
	(envelope-from miltonm@sullivan.realtime.net)
Received: (from miltonm@localhost)
	by sullivan.realtime.net (8.13.1/8.12.7/Submit) id l2LF32IJ008515
	for linuxppc-dev@ozlabs.org; Wed, 21 Mar 2007 09:03:02 -0600 (CST)
Date: Wed, 21 Mar 2007 09:03:02 -0600 (CST)
Subject: Re: [PATCH 2/4] powerpc: Add device tree utility functions to zImage
Sender: <miltonm@realtime.net>
From: Milton Miller <miltonm@bga.com>
To: David Gibson <david@gibson.dropbear.id.au>
In-Reply-To: <20070321063150.04BA4DDE9F@ozlabs.org>
Message-ID: <200703211030.l2LAU2TE099295@sullivan.realtime.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Following your reply to Scott's comments about space in the xlate_reg
thread, how about splitting the ones used in main.c which will always
be included from the others that are more for device tree pokers.

For that matter, your streamlining adds runtime overhead.  Why not
cache the checked or created phandle?

Also, in dt_path_getprop, did you want to call finddevice instead of
testing the function is not weak and undefined?

milton

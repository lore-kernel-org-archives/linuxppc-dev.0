Return-Path: <dave@frascone.com>
Received: from mail.frascone.com (frascone.com [204.49.99.9])
	by ozlabs.org (Postfix) with ESMTP id 3995167A6F
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Apr 2005 23:44:22 +1000 (EST)
Date: Wed, 6 Apr 2005 08:12:01 -0500
From: David Frascone <dave@frascone.com>
To: linuxppc-dev@ozlabs.org
Message-ID: <20050406081201.07b9bdce@greenlantern.frascone.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Bogomips?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Can this be right?  I'm getting This from a MPC-8260 (/proc/cpuinfo):

------------------------------------------------
cpu             : 82xx
core clock      : 199 MHz
CPM  clock      : 133 MHz
bus  clock      : 33 MHz
revision        : 1.1 (pvr 0081 0101)
bogomips        : 133.12
------------------------------------------------

And this from a MPC-8540
------------------------------------------------
cpu             : e500
revision        : 2.0 (pvr 8020 0020)
bogomips        : 190.05
Vendor          : Motorola SPS
Machine         : mpc8540ads
bus freq        : 666.666660 MHz
PVR             : 0x80200020
SVR             : 0x80300020
PLL setting     : 0x4
Memory          : 512 MB
------------------------------------------------


The second one looks way low . . . any ideas?

-Dave

-- 
David Frascone

Gimme back my face! You're getting it ugly.

Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 68812DDEDE
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 00:56:55 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l4EEuqhE003185
	for <linuxppc-dev@ozlabs.org>; Mon, 14 May 2007 10:56:52 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l4EEupaA204674
	for <linuxppc-dev@ozlabs.org>; Mon, 14 May 2007 08:56:51 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l4EEuplE008946
	for <linuxppc-dev@ozlabs.org>; Mon, 14 May 2007 08:56:51 -0600
Received: from [9.67.220.166] (wecm-9-67-220-166.wecm.ibm.com [9.67.220.166])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	l4EEuoC5008865
	for <linuxppc-dev@ozlabs.org>; Mon, 14 May 2007 08:56:50 -0600
Subject: [PATCH 0/3] Initial AMCC Bamboo support
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain
Date: Mon, 14 May 2007 09:56:48 -0500
Message-Id: <1179154608.3420.21.camel@zod.rchland.ibm.com>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi All,

The following patches add the initial AMCC Bamboo eval board support.  

The support for peripheral devices at the moment is rather limited as
the board is quite complicated in it's muxing of I/O lines.  Until the
bootwrapper can figure out how to setup the EBC peripherals based on the
dip switch settings, the DTS will lack any EBC devices.

As always, comments welcome.

josh

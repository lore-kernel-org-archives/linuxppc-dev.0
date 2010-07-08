Return-Path: <marcchidester@gmail.com>
Received: from mail-ww0-f52.google.com (mail-ww0-f52.google.com [74.125.82.52])
	by ozlabs.org (Postfix) with ESMTP id E79FBB6EF3
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Jul 2010 01:06:38 +1000 (EST)
Received: by wwb28 with SMTP id 28so1873167wwb.21
	for <linuxppc-dev@ozlabs.org>; Thu, 08 Jul 2010 08:06:36 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 8 Jul 2010 11:06:36 -0400
Message-ID: <AANLkTikrUvEicL1DaeLz9Vr-lE_hkKZqJi_7qzERZMu8@mail.gmail.com>
Subject: 405EX Rev D mis-identification?
From: Marc Chidester <marcchidester@gmail.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

It looks like the Rev D version of the 405EX chip without security
will be identified as a 405EXr, based on the values in the cpu_specs
table.  For 405EX/405EXr the pvr_mask is  0xffff0004 with the
pvr_value's as 0x12910004 and 0x12910000 respectively. I see that the
Rev D PVR value for the 405EX without security is 0x12911473, which
would mask out to the EXr value.

Is there an algorithm update needed or am I missing something?

Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id 85BC12BDB5
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 20 Nov 2004 01:25:22 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Date: Fri, 19 Nov 2004 08:25:18 -0600
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B06DBC9@ismail.innsys.innovsys.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: <morten.banzon@axxessit.no>
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: MPC82xx -- DPRAM1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: linuxppc-embedded-bounces@ozlabs.org=20
> [mailto:linuxppc-embedded-bounces@ozlabs.org] On Behalf Of=20
> morten.banzon@axxessit.no
> Sent: Thursday, November 18, 2004 20:24
> I think the only thing missing from the=20
> driver is to setup the now famous SMCx_BASE pointers. This is=20
> ofcourse=20
> possible to do, but there might be good reasons why it is not=20
> done.

Send a patch to fix this in the driver. I think most people on this list
would like the seriaql drivers to be totally independent of the
bootloader (no matter what it is).

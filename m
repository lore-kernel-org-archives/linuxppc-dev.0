Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id B3343DDF43
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Feb 2008 07:45:19 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Kernel oops while duming user core.
Date: Thu, 31 Jan 2008 14:45:17 -0600
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B03EE4990@ismail.innsys.innovsys.com>
In-Reply-To: <20080131204158.GV14201@localdomain>
References: <DCEAAC0833DD314AB0B58112AD99B93B03EE46B8@ismail.innsys.innovsys.com>
	<DCEAAC0833DD314AB0B58112AD99B93B03EE47A4@ismail.innsys.innovsys.com>
	<20080131201601.GA10501@loki.buserror.net>
	<20080131204158.GV14201@localdomain>
From: "Rune Torgersen" <runet@innovsys.com>
To: "Nathan Lynch" <ntl@pobox.com>,
	"Scott Wood" <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Nathan Lynch wrote:
> Scott Wood wrote:
>> Do you have a simple test case that we could try to reproduce?  I
>> tried a simple core dump on an 8280, and it worked.
>=20
> Is the crashing program multithreaded?  The first report had firefox
> triggering the oops.

The crashing program has 10 threads. (NPTL pthreads, glibc-2.5, gcc
4.1.2)

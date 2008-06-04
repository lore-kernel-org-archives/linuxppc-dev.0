Return-Path: <borntraeger@de.ibm.com>
Received: from mtagate3.uk.ibm.com (mtagate3.uk.ibm.com [195.212.29.136])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate3.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4DB24DDEE1
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Jun 2008 18:00:49 +1000 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate3.uk.ibm.com (8.13.8/8.13.8) with ESMTP id m5480LR4323494
	for <linuxppc-dev@ozlabs.org>; Wed, 4 Jun 2008 08:00:21 GMT
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com
	[9.149.37.212])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v8.7) with
	ESMTP id m5480L21602352
	for <linuxppc-dev@ozlabs.org>; Wed, 4 Jun 2008 09:00:21 +0100
Received: from d06av01.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av01.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id m5480K5P028759
	for <linuxppc-dev@ozlabs.org>; Wed, 4 Jun 2008 09:00:21 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC 1/3] hvc_console: rework setup to replace irq functions with
	callbacks (not word wrapped)
Date: Wed, 4 Jun 2008 10:00:16 +0200
References: <200806031444.21945.borntraeger@de.ibm.com>
	<200806031449.14385.borntraeger@de.ibm.com>
	<200806031930.09556.arnd@arndb.de>
In-Reply-To: <200806031930.09556.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200806041000.16291.borntraeger@de.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Jeremy Fitzhardinge <jeremy@goop.org>,
	Rusty Russell <rusty@rustcorp.com.au>, LKML <linux-kernel@vger.kernel.org>,
	Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Am Dienstag, 3. Juni 2008 schrieb Arnd Bergmann:
> I don't see a reason to make this data structure known to other files,
> so why not leave it in hvc_console.c?

Yes, Fixed. I moved it for a ealier version of this patch. Currently its not 
necessary. Dont know if I need to move it again if I work on Rusty's ideas.

Christian

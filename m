Return-Path: <SRS0+bf7e8443b56fb01442c6+972+infradead.org+dwmw2@canuck.srs.infradead.org>
Received: from canuck.infradead.org (canuck.infradead.org [205.233.218.70])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3C1C8679E1
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Apr 2006 22:57:57 +1000 (EST)
Subject: Re: Fedora 5 on POWER5
From: David Woodhouse <dwmw2@infradead.org>
To: Josef =?ISO-8859-1?Q?M=E1dl?= <jmadl@kts.cz>
In-Reply-To: <001201c6650b$e507b110$0c01a8c0@KTSJMXP>
References: <001201c6650b$e507b110$0c01a8c0@KTSJMXP>
Content-Type: text/plain; charset=UTF-8
Date: Sat, 22 Apr 2006 13:57:41 +0100
Message-Id: <1145710661.11909.244.camel@pmac.infradead.org>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2006-04-21 at 08:21 +0200, Josef Mádl wrote:
> I am trying to install fedora 5 on IBM i5 system. Instalation start,
> all seems to good to partitioning disk.
> Fedora see two disks /dev/sda (real disk - virtual disk prepared with
> CRTNWSSTG) and /dev/sdb (booting disk of instalation - Prep).
> I choise /dev/sda for creating linux partitions, fedora show me how it
> will be parted but try to write to /dev/sdb - it ends with error.
> 
> Do anybody know how solved this problem ?

I'm fairly sure I saw Paul helping someone work around this on Freenode
#fedora-ppc a couple of weeks ago.

-- 
dwmw2

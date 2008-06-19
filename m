Return-Path: <olof@lixom.net>
Received: from elcamino.pasemi.com (elcamino.pasemi.com [67.155.108.98])
	by ozlabs.org (Postfix) with ESMTP id 91B8FDDF8F
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jun 2008 00:53:52 +1000 (EST)
Message-Id: <F5386B83-6DD2-4503-9ADD-C0CDE21101ED@lixom.net>
From: Olof Johansson <olof@lixom.net>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200806191559.04852.arnd@arndb.de>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: [RFC 0/3] powerpc: memory copy routines tweaked for Cell
Date: Thu, 19 Jun 2008 09:53:49 -0500
References: <200806191753.51495.markn@au1.ibm.com>
	<200806191353.17323.arnd@arndb.de>
	<18522.19171.348796.482938@cargo.ozlabs.ibm.com>
	<200806191559.04852.arnd@arndb.de>
Cc: Mark Nelson <markn@au1.ibm.com>, Gunnar von Boehn <VONBOEHN@de.ibm.com>,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Michael Ellerman <ellerman@au1.ibm.com>, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 19, 2008, at 8:59 AM, Arnd Bergmann wrote:

> I assume it has suffered from bitrot and nobody tried to do better
> since the Power3 days. AFAICT, it hasn't seen any update since your
> original Power4 version from 2002.

I've got an out-of-tree optimized version for pa6t as well that I  
haven't bothered posting yet.

The real pain with the usercopy code is all the exception cases. If  
anyone has made a test harness to make sure they're all right, please  
do post it for others to use as well...


-Olof

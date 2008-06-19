Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18522.60641.706672.27167@cargo.ozlabs.ibm.com>
Date: Fri, 20 Jun 2008 09:33:53 +1000
From: Paul Mackerras <paulus@samba.org>
To: Gunnar von Boehn <VONBOEHN@de.ibm.com>
Subject: Re: [RFC 0/3] powerpc: memory copy routines tweaked for Cell
In-Reply-To: <OF44809729.FB9D2C51-ONC125746D.00429A93-C125746D.0042FB12@de.ibm.com>
References: <200806191753.51495.markn@au1.ibm.com>
	<200806191353.17323.arnd@arndb.de>
	<OF44809729.FB9D2C51-ONC125746D.00429A93-C125746D.0042FB12@de.ibm.com>
Cc: Mark Nelson <markn@au1.ibm.com>, linuxppc-dev@ozlabs.org,
	Michael Ellerman <ellerman@au1.ibm.com>, cbe-oss-dev@ozlabs.org,
	Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Gunnar von Boehn writes:

> I have no results for P5/P6, but I did some tests on JS21 aka PPC-970.
> On PPC-970 the CELL memcpy is faster than the current Linux routine.
> This becomes really visible when you really copy memory-to-memory and are
> not only working in the 2ndlevelcache.

Could you send some more details, like the actual copy speed you
measured and how you did the tests?

Thanks,
Paul.

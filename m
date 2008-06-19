Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [RFC 0/3] powerpc: memory copy routines tweaked for Cell
Date: Thu, 19 Jun 2008 15:59:04 +0200
References: <200806191753.51495.markn@au1.ibm.com>
	<200806191353.17323.arnd@arndb.de>
	<18522.19171.348796.482938@cargo.ozlabs.ibm.com>
In-Reply-To: <18522.19171.348796.482938@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200806191559.04852.arnd@arndb.de>
Cc: Mark Nelson <markn@au1.ibm.com>, Gunnar von Boehn <VONBOEHN@de.ibm.com>,
	Paul Mackerras <paulus@samba.org>, cbe-oss-dev@ozlabs.org,
	Michael Ellerman <ellerman@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 19 June 2008, Paul Mackerras wrote:
> Arnd Bergmann writes:
> 
> > Have you tried running this code on other platforms to see if it
> > actually performs worse on any of them? I would guess that the
> > older code also doesn't work too well on Power 5 and Power 6,
> 
> Why would you guess that?

I remembered that Gunnar had done some tests on other CPUs showing
that an earlier version of the code was better than the kernel
memcpy.
Also, I had tried to trace the history of the usercopy function
and found that it predates most of the CPUs in current use, so
I assume it has suffered from bitrot and nobody tried to do better
since the Power3 days. AFAICT, it hasn't seen any update since your
original Power4 version from 2002.

	Arnd <><

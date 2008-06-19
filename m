Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18522.19171.348796.482938@cargo.ozlabs.ibm.com>
Date: Thu, 19 Jun 2008 22:02:43 +1000
From: Paul Mackerras <paulus@samba.org>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC 0/3] powerpc: memory copy routines tweaked for Cell
In-Reply-To: <200806191353.17323.arnd@arndb.de>
References: <200806191753.51495.markn@au1.ibm.com>
	<200806191353.17323.arnd@arndb.de>
Cc: Mark Nelson <markn@au1.ibm.com>, linuxppc-dev@ozlabs.org,
	Gunnar von Boehn <VONBOEHN@de.ibm.com>, cbe-oss-dev@ozlabs.org,
	Michael Ellerman <ellerman@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Arnd Bergmann writes:

> Have you tried running this code on other platforms to see if it
> actually performs worse on any of them? I would guess that the
> older code also doesn't work too well on Power 5 and Power 6,

Why would you guess that?

Paul.

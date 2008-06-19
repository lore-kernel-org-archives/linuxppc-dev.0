Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [RFC 0/3] powerpc: memory copy routines tweaked for Cell
Date: Thu, 19 Jun 2008 13:53:16 +0200
References: <200806191753.51495.markn@au1.ibm.com>
In-Reply-To: <200806191753.51495.markn@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200806191353.17323.arnd@arndb.de>
Cc: Mark Nelson <markn@au1.ibm.com>, Gunnar von Boehn <VONBOEHN@de.ibm.com>,
	cbe-oss-dev@ozlabs.org, Michael Ellerman <ellerman@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 19 June 2008, Mark Nelson wrote:
> The plan is to use Michael Ellerman's code patching work so that at runtime
> if we're running on a Cell machine the new routines are called but otherwise
> the existing memory copy routines are used.

Have you tried running this code on other platforms to see if it
actually performs worse on any of them? I would guess that the
older code also doesn't work too well on Power 5 and Power 6, so the
cell optimized version could give us a significant advantage as well,
albeit less than another CPU specific version.

	Arnd <><

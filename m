Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [RFC] powerpc: experimental of serial port driver
Date: Sat, 9 Dec 2006 00:42:57 +0100
References: <200612072140.47405.arnd@arndb.de>
	<200612081612.28385.arnd@arndb.de>
	<1165611049.1103.37.camel@localhost.localdomain>
In-Reply-To: <1165611049.1103.37.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200612090042.58601.arnd@arndb.de>
Cc: David Woodhouse <dwmw2@infradead.org>, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 08 December 2006 21:50, Benjamin Herrenschmidt wrote:
> We sill need to fixup legacy_serial to detect them on opb right ?

Yes, I have another patch for that. Currently, the port registers
as compatible="ns16750", which is different from all the others
in legacy_serial. Do you think it should be 
compatible="nc16750\0ns16550" instead, so we can use the same
as the others? It actually _is_ compatible to 16550 anyway.

	Arnd <><

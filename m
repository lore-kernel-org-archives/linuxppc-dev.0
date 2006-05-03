Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17496.6519.733076.663815@cargo.ozlabs.ibm.com>
Date: Wed, 3 May 2006 12:46:15 +1000
From: Paul Mackerras <paulus@samba.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [Cbe-oss-dev] [PATCH 11/13] cell: split out board specific files
In-Reply-To: <801072F8-7701-4BD7-81FB-A8C1AA534C2E@kernel.crashing.org>
References: <20060429232812.825714000@localhost.localdomain>
	<200605020150.14152.arnd@arndb.de>
	<1900A234-BE31-4292-87E1-5C02F12A440D@kernel.crashing.org>
	<200605021259.24157.arnd@arndb.de>
	<801072F8-7701-4BD7-81FB-A8C1AA534C2E@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Segher Boessenkool writes:

> > Well, it could run on other platforms, except:
> >
> > - it requires a few properties in the device tree (local-mac-address,
> >   firmware), so it should also depend on PPC
> 
> The portions of code that require OF should have appropriate #ifdef  
> guards.

So you're suggesting that we change the Makefile so we can *add*
ifdefs?  Usually we do it the other way around. :)

Paul.

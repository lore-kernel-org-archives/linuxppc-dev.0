Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: cbe-oss-dev@ozlabs.org
Subject: Re: [Cbe-oss-dev] [PATCH 11/13] cell: split out board specific files
Date: Tue, 2 May 2006 12:59:23 +0200
References: <20060429232812.825714000@localhost.localdomain>
	<200605020150.14152.arnd@arndb.de>
	<1900A234-BE31-4292-87E1-5C02F12A440D@kernel.crashing.org>
In-Reply-To: <1900A234-BE31-4292-87E1-5C02F12A440D@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200605021259.24157.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 02 May 2006 02:06, Segher Boessenkool wrote:
> Is there any reason the driver wouldn't build and/or run on other
> platforms?  If so, fix it.  If not, just make it
> 
>         depends on PCI

Well, it could run on other platforms, except:

- it requires a few properties in the device tree (local-mac-address,
  firmware), so it should also depend on PPC
- It's not actually PCI at all, but on an internal bus that has
  something close enough to a PCI config space.

	Arnd <><

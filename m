Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: cbe-oss-dev@ozlabs.org
Subject: Re: [Cbe-oss-dev] Cell and new CPU feature bits
Date: Fri, 19 May 2006 12:11:18 +0200
References: <1148011621.13249.7.camel@localhost.localdomain>
In-Reply-To: <1148011621.13249.7.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200605191211.18737.arnd@arndb.de>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 19 May 2006 06:07, Benjamin Herrenschmidt wrote:
>  - Extended implementation of dcbt. (Another bit ? Or sould we just have
> a "CELL" bit ? In which case should it cover the altivec additions too
> or are those likely to exist in future non-Cell processors ?)

Isn't that already covered by PPC_FEATURE_CELL? Git log shows

| commit a7ddc5e85351931b67a48afa22788d77763837d8
| Author: Paul Mackerras <paulus@samba.org>
| Date:   Thu Nov 10 14:29:18 2005 +1100
|
|    powerpc: Add user CPU features for POWER4, POWER5, POWER5+ and Cell.
|
|    This is at the request of the glibc folks, who want to use these bits
|    to select libraries optimized for the microarchitecture and new
|    instructions in these processors.
|
|    Signed-off-by: Paul Mackerras <paulus@samba.org>

	Arnd <><

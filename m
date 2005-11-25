Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17286.35454.210202.789136@cargo.ozlabs.ibm.com>
Date: Fri, 25 Nov 2005 14:52:30 +1100
From: Paul Mackerras <paulus@samba.org>
To: hs@denx.de
In-Reply-To: <AHEILKONAKAEJPHNMOPNEELBCDAA.hs@denx.de>
References: <AHEILKONAKAEJPHNMOPNEELBCDAA.hs@denx.de>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH]	ppc32:	Add defconfig File for PM826 Board.
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Heiko Schocher writes:

> the following Patch (against 2.6 kernel.org tree, COMMIT_ID:
> f093182d313edde9b1f86dbdaf40ba4da2dbd0e7) adds the defconfig
> File for the PM826 Board from Microsys.

Your first patch added a pm82x_defconfig; why do we need both a
pm826_defconfig and a pm82x_defconfig?

Paul.

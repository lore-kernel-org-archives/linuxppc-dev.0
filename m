Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18032.40314.440212.19149@cargo.ozlabs.ibm.com>
Date: Thu, 14 Jun 2007 11:44:26 +1000
From: Paul Mackerras <paulus@samba.org>
To: arnd@arndb.de
Subject: Re: [patch 12/13] powerpc: fix building without PCI
In-Reply-To: <20070612163751.979776796@arndb.de>
References: <20070612163016.253915076@arndb.de>
	<20070612163751.979776796@arndb.de>
Cc: linuxppc-dev@ozlabs.org, Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

arnd@arndb.de writes:

> Some code looks can be configured to be built without
> PCI support, but does not work properly.

I don't think it makes sense to build a chrp kernel without PCI.  I
would rather just always select PCI for chrp rather than uglifying the
code with all those ifdefs.

Paul.

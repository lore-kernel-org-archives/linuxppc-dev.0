Return-Path: <mgreer@mvista.com>
Date: Tue, 27 Mar 2007 18:04:44 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: linuxppc-dev <Linuxppc-dev@ozlabs.org>
Subject: [RFC 0/8] powerpc: Add initial arch/powerpc support for
	Marvell/mv64x60
Message-ID: <20070328010444.GB302@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dale Farnsworth <dfarnsworth@mvista.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

The following set of patches add initial support for the Marvell
hostbridge (mv64x60) to the arch/powerpc code.  I did most of the
bootwrapper code and Dale Farnsworth did most of the kernel code.

Since the bootwrapper is moving so fast, we're sending these out for
comment but not asking for submission because they're already out of date.
They are based on Milton Miller's and Scott Woods patches from about a
week ago.  We'll try to respin on the latest patches every couple weeks
or so.

There will be another set of patches for the prpmc280/2800 which are
based on these patches coming shortly.

Mark
--

Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Carl Love <cel@us.ibm.com>
Subject: Re: [Patch 0/3] OProfile SPU event profiling support for IBM Cell
	processor
Date: Tue, 25 Nov 2008 17:00:30 +0100
References: <1227568781.6509.198.camel@carll-linux-desktop>
In-Reply-To: <1227568781.6509.198.camel@carll-linux-desktop>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200811251700.30926.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, cel <cel@linux.vnet.ibm.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	oprofile-list@lists.sourceforge.net, cbe-oss-dev <cbe-oss-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 25 November 2008, Carl Love wrote:
> This patch set consists of two kernel patches and one user level patch
> to add SPU event based profiling support to OProfile for the IBM Cell
> processor. =A0The first patch in the series is the user level patch that
> adds the needed events and event checking to the user tool. =A0The second
> patch is the first of two kernel patches. =A0It makes some structural
> changes to the kernel code to make it easier to add the specific
> functions for doing SPU event profiling. =A0The first kernel patch does
> not make any functional changes. =A0The third patch in the series is the
> second kernel patch where the actual SPU event profiling code support is
> added to the kernel.

Thanks for your submission!

I can't comment on the oprofile user code, but I have some comments
on the implementation in the third patch.

Are the patches interdependent, or will old versions of the oprofile
tool work with new kernels and vice versa?

	Arnd <><

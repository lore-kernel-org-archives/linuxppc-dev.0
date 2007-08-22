Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: paulus@samba.org
Subject: git tree,
	Re: [patch 0/5] (hopefully) final 2.6.23 fixes for cell platform
Date: Wed, 22 Aug 2007 19:15:12 +0200
References: <20070822170124.764128591@arndb.de>
In-Reply-To: <20070822170124.764128591@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200708221915.12355.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 22 August 2007, Arnd Bergmann wrote:
> Hi Paul,
> 
> A few bugs came up on the cell platform when testing on the lastest
> prototype version of a future hardware. The first three patches are
> all meant to track changes required for the fixes that have gone
> into the firmware. Patch 4 is for a bug that showed up during testing,
> and the final patch is the defconfig update that you probably want
> to do for the other platforms as well.
> 
> Please forward for inclusion in 2.6.23!

If you prefer the git tree, please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/arnd/cell-2.6.git for-2.6.23

	Arnd <><

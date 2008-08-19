Return-Path: <robert.richter@amd.com>
Date: Tue, 19 Aug 2008 13:53:18 +0200
From: Robert Richter <robert.richter@amd.com>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: powerpc/cell/oprofile: avoid double free of profile buffer
Message-ID: <20080819115317.GD1488@erda.amd.com>
References: <1217620879.15667.145.camel@carll-linux-desktop>
	<18591.30474.127939.243247@cargo.ozlabs.ibm.com>
	<200808110918.57293.arnd@arndb.de>
	<200808110925.44243.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <200808110925.44243.arnd@arndb.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, oprofile-list@lists.sourceforge.net,
	cel <cel@linux.vnet.ibm.com>, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 11.08.08 09:25:43, Arnd Bergmann wrote:
> From: Carl Love <cel@us.ibm.com>
> 
> If an error occurs on opcontrol start, the event and per cpu buffers
> are released.  If later opcontrol shutdown is called then the free
> function will be called again to free buffers that no longer
> exist.  This results in a kernel oops.  The following changes
> prevent the call to delete buffers that don't exist.
> 
> Signed-off-by: Carl Love <carll@us.ibm.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Robert Richter <robert.richter@amd.com>

-Robert

-- 
Advanced Micro Devices, Inc.
Operating System Research Center
email: robert.richter@amd.com

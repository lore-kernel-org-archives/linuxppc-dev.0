Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y8xjk0T0TzDr3n
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  8 Oct 2017 19:43:38 +1100 (AEDT)
In-Reply-To: <20170928133426.19454-1-seth.forshee@canonical.com>
To: Seth Forshee <seth.forshee@canonical.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Shuah Khan <shuah@kernel.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Seth Forshee <seth.forshee@canonical.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: selftests/powerpc: Use snprintf to construct DSCR sysfs interface
 paths
Message-Id: <3y8xjj5K9Mz9t5R@ozlabs.org>
Date: Sun,  8 Oct 2017 19:43:37 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-09-28 at 13:34:26 UTC, Seth Forshee wrote:
> Currently sprintf is used, and while paths should never exceed
> the size of the buffer it is theoretically possible since
> dirent.d_name is 256 bytes. As a result this trips
> -Wformat-overflow, and since the test is built with -Wall -Werror
> the causes the build to fail. Switch to using snprintf and skip
> any paths which are too long for the filename buffer.
> 
> Signed-off-by: Seth Forshee <seth.forshee@canonical.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/06755a871314c7443a89c09650cdb3

cheers

Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17490.53283.417700.559725@cargo.ozlabs.ibm.com>
Date: Sat, 29 Apr 2006 12:32:03 +1000
From: Paul Mackerras <paulus@samba.org>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 0/4] NUMA support for spufs
In-Reply-To: <20060429011827.502138000@localhost.localdomain>
References: <20060429011827.502138000@localhost.localdomain>
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

Arnd Bergmann writes:

> The current version of spufs breaks upon boot when NUMA support is enabled.
> I'd like to fix that before 2.6.17 so we can use the same kernel image
> on Cell that we use on other powerpc systems using NUMA.

Andrew,

If 2/4 of this series looks OK to you to go into 2.6.17, let me know
and I'll push the others to Linus (or you can if you prefer).

Thanks,
Paul.

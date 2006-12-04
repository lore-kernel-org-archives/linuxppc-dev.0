Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17779.37050.4039.942954@cargo.ozlabs.ibm.com>
Date: Mon, 4 Dec 2006 14:06:34 +1100
From: Paul Mackerras <paulus@samba.org>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: [2.6 patch] arch/powerpc/Kconfig: fix the EMBEDDED6xx dependencies
In-Reply-To: <20061201115410.GV11084@stusta.de>
References: <20061201115410.GV11084@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Adrian Bunk writes:

> This patch changes the EMBEDDED6xx dependencies to the equivalent 
> dependency that seems to have been intended.

Nack - CONFIG_EMBEDDED6xx is going away entirely, soon.

Paul.

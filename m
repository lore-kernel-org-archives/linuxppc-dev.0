Return-Path: <psomas@ece.ntua.gr>
Received: from ulysses.noc.ntua.gr (ulysses.noc.ntua.gr [147.102.222.230])
	by ozlabs.org (Postfix) with ESMTP id 99471B715F
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  9 May 2011 06:02:45 +1000 (EST)
Message-ID: <4DC6F6D8.40303@ece.ntua.gr>
Date: Sun, 08 May 2011 23:02:32 +0300
From: Stratos Psomadakis <psomas@ece.ntua.gr>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 0/2] ppc/cleaup: Fix compiler warnings
References: <1304777491-7947-1-git-send-email-psomas@cslab.ece.ntua.gr>
In-Reply-To: <1304777491-7947-1-git-send-email-psomas@cslab.ece.ntua.gr>
Content-Type: text/plain; charset=ISO-8859-1
Cc: paulus@samba.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/07/2011 05:11 PM, Stratos Psomadakis wrote:
> Fix compiler warnings in ppc code, which can lead to build failure, if
> CONFIG_PPC_WERROR is set (default).
>
>  arch/powerpc/include/asm/pgtable-ppc64.h |   13 ++++++-------
>  arch/powerpc/kernel/Makefile             |    2 +-
>  2 files changed, 7 insertions(+), 8 deletions(-)
forgot to cc the maintainers

-- 
Stratos Psomadakis
<psomas@ece.ntua.gr>

Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18579.41468.973986.175252@cargo.ozlabs.ibm.com>
Date: Sat, 2 Aug 2008 09:53:32 +1000
From: Paul Mackerras <paulus@samba.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 00/10] powerpc: Remove use of CONFIG_PPC_MERGE
In-Reply-To: <1217609060-6381-1-git-send-email-galak@kernel.crashing.org>
References: <1217609060-6381-1-git-send-email-galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala writes:

> This set of patches remove Kconfig and code related to CONFIG_PPC_MERGE
> and !CONFIG_PPC_MERGE.  There is some discussion about that one last
> use of !PPC_MERGE with respect to the 4xx MTD_NAND_NDFC driver.
> 
> Paul, is this something you'd be willing to entertain for 2.6.27?

Yes, since it's just dead code removal.

Paul.

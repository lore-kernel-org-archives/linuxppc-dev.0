Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18436.23196.673130.542635@cargo.ozlabs.ibm.com>
Date: Tue, 15 Apr 2008 17:34:52 +1000
From: Paul Mackerras <paulus@samba.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 03/12] [POWERPC] Remove and replace uses of PPC_MEMSTART
	with memstart_addr
In-Reply-To: <1207824531-27168-4-git-send-email-galak@kernel.crashing.org>
References: <1207824531-27168-1-git-send-email-galak@kernel.crashing.org>
	<1207824531-27168-2-git-send-email-galak@kernel.crashing.org>
	<1207824531-27168-3-git-send-email-galak@kernel.crashing.org>
	<1207824531-27168-4-git-send-email-galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala writes:

> +phys_addr_t memstart_addr;
> +EXPORT_SYMBOL(memstart_addr);

Do you have a modular user of memstart_addr in mind?

Paul.

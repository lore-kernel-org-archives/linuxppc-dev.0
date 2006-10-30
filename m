Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17733.28614.62353.822225@cargo.ozlabs.ibm.com>
Date: Mon, 30 Oct 2006 14:21:42 +1100
From: Paul Mackerras <paulus@samba.org>
To: Li Yang <leoli@freescale.com>
Subject: Re: [PATCH] qe_lib: Remove immrbar_virt_to_phys() function
In-Reply-To: <453F44E6.8030706@freescale.com>
References: <453F44E6.8030706@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Li Yang writes:

> Remove private physical address mapping routine in qe_lib.  Users
> of qe_lib should use generic functions like iopa().
> The change also addresses a bug found by Timur Tabi that cmd_input
> got mapped in qe_issue_cmd().  It should be written to CECDR
> unmodified.

Do you mean that the argument to qe_issue_cmd is a physical address?
It seems to me that the bug fix you mention is the main thing the
patch does, and the removal of immrvar_virt_to_phys is a cleanup on
the side that is made possible by the bugfix.

Paul.

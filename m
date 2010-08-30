Return-Path: <B04825@freescale.com>
Message-ID: <4C7C16F8.7060905@freescale.com>
Date: Mon, 30 Aug 2010 15:39:20 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Julia Lawall <julia@diku.dk>
Subject: Re: [PATCH 5/7] arch/powerpc/sysdev/qe_lib/qe.c: Add of_node_put
	to avoid memory leak
References: <1283075566-27441-1-git-send-email-julia@diku.dk>
	<1283075566-27441-6-git-send-email-julia@diku.dk>
In-Reply-To: <1283075566-27441-6-git-send-email-julia@diku.dk>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: devicetree-discuss@lists.ozlabs.org, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Julia Lawall wrote:
> Add a call to of_node_put in the error handling code following a call to
> of_find_compatible_node.

Acked-by: Timur Tabi <timur@freescale.com>

Thanks, Julia.  Your work in finding these kinds of bugs is very much
appreciated.

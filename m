Return-Path: <nick@nick-andrew.net>
Received: from vps1.tull.net (unknown [66.180.172.116])
	by ozlabs.org (Postfix) with SMTP id D4DFCDE14B
	for <linuxppc-dev@ozlabs.org>; Sun, 13 Apr 2008 02:36:30 +1000 (EST)
Date: Sun, 13 Apr 2008 02:29:40 +1000
From: Nick Andrew <nick@nick-andrew.net>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [LMB][1/2] Fix some whitespace and other formatting issues,
	use pr_debug
Message-ID: <20080412162940.GB29599@tull.net>
References: <18432.18107.29491.115996@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <18432.18107.29491.115996@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Apr 12, 2008 at 03:20:59PM +1000, Paul Mackerras wrote:
> +	pr_debug("\n    reserved.cnt	  = 0x%lx\n", lmb.reserved.cnt);

This will only output an empty line at KERN_DEBUG level and the rest
will be at default_message_loglevel. Problem is fixed my my patch in msg
<20080412161733.24882.30930.stgit@marcab.local.tull.net>

However, is a blank line in the log necessary?

Nick.

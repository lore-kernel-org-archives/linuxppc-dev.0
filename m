Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18433.64824.293863.930250@cargo.ozlabs.ibm.com>
Date: Sun, 13 Apr 2008 22:31:52 +1000
From: Paul Mackerras <paulus@samba.org>
To: Nick Andrew <nick@nick-andrew.net>
Subject: Re: [LMB][1/2] Fix some whitespace and other formatting issues,
	use pr_debug
In-Reply-To: <20080412162940.GB29599@tull.net>
References: <18432.18107.29491.115996@cargo.ozlabs.ibm.com>
	<20080412162940.GB29599@tull.net>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Nick Andrew writes:

> On Sat, Apr 12, 2008 at 03:20:59PM +1000, Paul Mackerras wrote:
> > +	pr_debug("\n    reserved.cnt	  = 0x%lx\n", lmb.reserved.cnt);
> 
> This will only output an empty line at KERN_DEBUG level and the rest
> will be at default_message_loglevel. Problem is fixed my my patch in msg
> <20080412161733.24882.30930.stgit@marcab.local.tull.net>
> 
> However, is a blank line in the log necessary?

No, and in fact the whole routine is probably not necessary any more.

Paul.

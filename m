Return-Path: <dale@farnsworth.org>
Received: from xyzzy.farnsworth.org (unknown [65.200.49.142])
	by ozlabs.org (Postfix) with SMTP id 8CBA92BD6A
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  6 Oct 2004 06:57:45 +1000 (EST)
From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Tue, 5 Oct 2004 13:51:02 -0700
To: linuxppc-embedded@ozlabs.org
Message-ID: <20041005205102.GA17718@xyzzy>
References: <35fb2e5904100415285979b343@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <35fb2e5904100415285979b343@mail.gmail.com>
Subject: Re: smc91111
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, Oct 04, 2004 at 10:28:26PM +0000, Jon Masters wrote:
> 
> Who is using the SMC91111 family of MACs and if so which driver do you use?

On the redwood5 and redwood6 boards I use the smc91x driver from
bk://linux.bkbits.net/linux-2.6/drivers/net/smc91x.[ch].  I had to add
redwood-specific in/out macros to smc91x.h, and use the platform_device
interface rather than OCP, but it's nice to have a single smc91x driver.

-Dale

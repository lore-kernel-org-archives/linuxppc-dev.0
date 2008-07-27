Return-Path: <glikely@secretlab.ca>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.168])
	by ozlabs.org (Postfix) with ESMTP id 54DF0DDE08
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 27 Jul 2008 14:04:44 +1000 (EST)
Received: by wf-out-1314.google.com with SMTP id 24so4716513wfg.15
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 26 Jul 2008 21:04:42 -0700 (PDT)
Date: Sat, 26 Jul 2008 19:36:15 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Joachim Meyer <Jogi95@web.de>
Subject: Re: XSysAce: Queue is plugged
Message-ID: <20080727013615.GJ12191@secretlab.ca>
References: <870343913@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <870343913@web.de>
Sender: Grant Likely <glikely@secretlab.ca>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Jul 10, 2008 at 04:49:21PM +0200, Joachim Meyer wrote:
> Hi
> 
> XSysAce: Queue is plugged
> Can someone say me what this means and how to get rid of it?
> I use a 2.6.23 xilinx Kernel on a XUPv2p. In the Kernel config-menu are 2 sysace drivers:
> < > Xilinx SystemACE support
> and 
> < > Xilinx SystemACE support (old driver)
> 
> I'm using the old driver because if I try to compile with the other it ends in this:
> 

The new driver compiles fine in 2.6.26.  I think it is more robust than
the old sysace driver.  See if you can port forward to a more recent
kernel; or you could try plucking the current driver out of Linus' tree
and trying it on your older kernel (but you won't get much support that
way).

g.

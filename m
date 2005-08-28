Return-Path: <marcelo.tosatti@cyclades.com>
Received: from parcelfarce.linux.theplanet.co.uk
	(parcelfarce.linux.theplanet.co.uk [195.92.249.252])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8D345680D8
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 28 Aug 2005 12:24:09 +1000 (EST)
Date: Sat, 27 Aug 2005 23:18:44 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Jan.Schneider@honeywell.com
Message-ID: <20050828021844.GA26869@dmt.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: Debug Register MPC855
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Jan,

> I have made som changes on kernel 2.4.18 to get access to the Debug
> Registers on a MPC855.
> Please apply and let me know whether the kernel runs stable or not.
> I need this support for the gdb to set Hardware Breakpoints on a MPC855
> target.

Did you wrote gdb support for it? Current gdb 6.3 uses the trap approach

  bdm_ppc_ops.to_insert_breakpoint = ocd_insert_breakpoint;
  bdm_ppc_ops.to_remove_breakpoint = ocd_remove_breakpoint;

Your patch looks good overall (needs some aesthetic cleanups). 

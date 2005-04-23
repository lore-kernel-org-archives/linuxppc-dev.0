Return-Path: <marcelo.tosatti@cyclades.com>
Received: from parcelfarce.linux.theplanet.co.uk
	(parcelfarce.linux.theplanet.co.uk [195.92.249.252])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 35D8967AC5
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 24 Apr 2005 03:48:02 +1000 (EST)
Date: Sat, 23 Apr 2005 09:42:45 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Joakim Tjernlund <Joakim.Tjernlund@lumentis.se>
Message-ID: <20050423124245.GJ12703@logos.cnet>
References: <BCEFJBPJCGFCNMMMIDBHMEIHCLAA.Joakim.Tjernlund@lumentis.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <BCEFJBPJCGFCNMMMIDBHMEIHCLAA.Joakim.Tjernlund@lumentis.se>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [26-devel] v2.6 performance slowdown on MPC8xx: Measuring TLB
	cache misses
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Joakim,

On Sat, Apr 23, 2005 at 07:23:51PM +0200, Joakim Tjernlund wrote:
> > Now, what is the best way to bring the performance back to v2.4 levels? 
> > 
> > For this "dd" test, which is dominated by "sys_read/sys_write", I thought 
> > of trying to bring the hotpath functions into the same pages, thus
> > decreasing the number of page translations required for such tasks.
> > 
> > Comments are appreciated
> 
> Does CONFIG_PIN_TLB make a difference?

No it does not. 

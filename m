Return-Path: <dale@farnsworth.org>
Received: from xyzzy.farnsworth.org (unknown [65.200.49.142])
	by ozlabs.org (Postfix) with SMTP id 23FB567A6D
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  1 Apr 2005 09:31:42 +1000 (EST)
From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Thu, 31 Mar 2005 16:31:38 -0700
To: linuxppc-embedded@ozlabs.org
Message-ID: <20050331233138.GB2273@xyzzy>
References: <20050331204729.GA29785@xyzzy>
	<20050331210806.GA5694@gate.ebshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050331210806.GA5694@gate.ebshome.net>
Subject: Re: [PATCH 2.6.10-rc2] ppc32: Add usb support to IBM stb04xxx
	platforms
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Mar 31, 2005 at 01:08:07PM -0800, Eugene Surovegin wrote:
> Dale, please, don't mess with UIC registers directly, there is a 
> cleaner way to set this up. 
> 
> Take a look at how this is done in other 4xx ports
> (ppc4xx_core_uic_cfg & ppc4xx_uic_ext_irq_cfg).

Thanks for the heads up Eugene.  I'll submit an updated patch shortly.

-Dale

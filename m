Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 01F41679E7
	for <linuxppc-dev@ozlabs.org>; Sun,  2 Apr 2006 08:33:01 +1000 (EST)
Date: Sat, 1 Apr 2006 14:32:59 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: "tvec_bases too large for per-cpu data" commit broke
	early_serial_setup()
Message-ID: <20060401223259.GB5748@gate.ebshome.net>
References: <20060401205336.GA5748@gate.ebshome.net>
	<20060401140610.2ec67738.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060401140610.2ec67738.akpm@osdl.org>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, jbeulich@novell.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Apr 01, 2006 at 02:06:10PM -0800, Andrew Morton wrote:

[snip]

> Early boot is ugly.
> 
> Does this fix it?

Yep, it works now.

Thanks, Andrew.

-- 
Eugene

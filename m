Return-Path: <willis@arlut.utexas.edu>
Received: from ns4.arlut.utexas.edu (ns4.arlut.utexas.edu [66.162.93.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EA24BDDE37
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 26 Oct 2007 07:50:10 +1000 (EST)
Received: from ns2.arlut.utexas.edu (ns2.arlut.utexas.edu [146.6.211.1])
	by ns4.arlut.utexas.edu (8.13.7/8.13.7) with ESMTP id l9PLnsVC021639
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 25 Oct 2007 16:49:54 -0500 (CDT)
Subject: Re: MPC85xx and linux IDE driver
From: Michael Brian Willis <willis@arlut.utexas.edu>
To: Ben Warren <bwarren@qstreams.com>
In-Reply-To: <471657FB.3040806@qstreams.com>
References: <1192213784.4862.48.camel@louie> <470FCF8A.1000504@qstreams.com>
	<1192643237.4929.41.camel@louie>  <471657FB.3040806@qstreams.com>
Content-Type: text/plain
Date: Thu, 25 Oct 2007 16:49:24 -0500
Message-Id: <1193348964.29111.71.camel@louie>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, 2007-10-17 at 14:44 -0400, Ben Warren wrote:

> This device driver is a platform driver, so you need to register a 
> platform device somewhere in your board-specific init code that contains 
> the hardware details (memory mapping and IRQ #).  

After modifying your init code and putting it in my board specific ".c"
file everything is working great. 

Thanks again for all of your help!

Michael Willis

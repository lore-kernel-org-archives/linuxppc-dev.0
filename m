Return-Path: <g.jaeger@sysgo.com>
Received: from mail.sysgo.com (mail.sysgo.com [62.8.134.5])
	by ozlabs.org (Postfix) with ESMTP id B553D67F97
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 10 Aug 2005 00:16:11 +1000 (EST)
From: Gerhard Jaeger <g.jaeger@sysgo.com>
To: linuxppc-embedded@ozlabs.org
Date: Tue, 9 Aug 2005 16:15:53 +0200
References: <20050809140428.13450.qmail@web41211.mail.yahoo.com>
In-Reply-To: <20050809140428.13450.qmail@web41211.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200508091615.53736.g.jaeger@sysgo.com>
Cc: Eric Kampman <erickampman@yahoo.com>
Subject: Re: MPC8555CDS & CCSRBAR
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tuesday 09 August 2005 16:04, Eric Kampman wrote:
> Trying to port an SEC driver to Linux/PPC8555. Reading
> the default CCSRBAR @ 0xFF700000 I read 0xFFFFFFFF
> which is wrong. Looking at Metrowerks init files and
> uboot code (1.1.2) I see it's likely been moved to
> 0xE0000000, but I get a seg fault when I try to read
> there. 
> 
> So, what am I doing wrong, and even better, how do I
> at runtime find out where CCSRBAR is? Thanks in
> advance, and please forgive the likely ignorance, 
> 
> Eric
> 

use the get_ccsrbar() function to get the address, then ioremap()
will be your friend ;)

HTH
Gerhard


-- 
Gerhard Jaeger <gjaeger@sysgo.com>            
SYSGO AG                      Embedded and Real-Time Software
www.sysgo.com | www.elinos.com | www.pikeos.com | www.osek.de 

Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 396C32C007B
 for <linuxppc-dev@ozlabs.org>; Thu, 15 Nov 2012 07:48:27 +1100 (EST)
Message-ID: <1352926097.23412.24.camel@pasglop>
Subject: Re: [PATCH] TTY: hvc_console, fix port reference count going to
 zero prematurely
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Greg KH <gregkh@linuxfoundation.org>
Date: Thu, 15 Nov 2012 07:48:17 +1100
In-Reply-To: <20121114150901.GA2371@kroah.com>
References: <20121114081547.GA573@bloggs.ozlabs.ibm.com>
 <50A36844.7080207@suse.cz> <1352897279.23412.22.camel@pasglop>
 <20121114150901.GA2371@kroah.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
 Jiri Slaby <jslaby@suse.cz>, anton@samba.org, alan@linux.intel.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2012-11-14 at 07:09 -0800, Greg KH wrote:
> > So who's merging it ?
> 
> Give me a chance to at least wake up please :)

Sure ;-) Just asking since I'm about to cook up a powerpc batch :-)

> I will.

Thanks ! It should go into stable 3.6 as well.

Cheers,
Ben.

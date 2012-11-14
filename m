Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 984752C0095
 for <linuxppc-dev@ozlabs.org>; Thu, 15 Nov 2012 07:58:05 +1100 (EST)
Message-ID: <1352926674.23412.32.camel@pasglop>
Subject: Re: [PATCH] TTY: hvc_console, fix port reference count going to
 zero prematurely
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Greg KH <gregkh@linuxfoundation.org>
Date: Thu, 15 Nov 2012 07:57:54 +1100
In-Reply-To: <20121114205407.GA7937@kroah.com>
References: <20121114081547.GA573@bloggs.ozlabs.ibm.com>
 <50A36844.7080207@suse.cz> <1352897279.23412.22.camel@pasglop>
 <20121114150901.GA2371@kroah.com> <1352926097.23412.24.camel@pasglop>
 <20121114205407.GA7937@kroah.com>
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

On Wed, 2012-11-14 at 12:54 -0800, Greg KH wrote:
> > Thanks ! It should go into stable 3.6 as well.
> 
> Why?  The offending patch didn't show up until 3.7-rc1.

Ah, my bad, I though Paulus had observed the problem with 3.6 as well
but it looks like you are right. So 3.7 then.

Thanks.

Cheers,
Ben.

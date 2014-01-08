Return-Path: <gregkh@linuxfoundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12]) by ozlabs.org (Postfix) with ESMTP id 476572C00BC
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jan 2014 12:29:29 +1100 (EST)
Date: Tue, 7 Jan 2014 17:29:57 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: drivers/tty: ehv_bytechan fails to build as a module
Message-ID: <20140108012957.GA7474@kroah.com>
References: <20131209160310.7f81a1bc@kryten>
 <20140104191537.GA9051@roeck-us.net>
 <1389144063.8284.5.camel@snotra.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1389144063.8284.5.camel@snotra.buserror.net>
Cc: dvaleev@suse.com, paulus@samba.org, Anton Blanchard <anton@samba.org>,
 linuxppc-dev@lists.ozlabs.org, timur@freescale.com,
 Guenter Roeck <linux@roeck-us.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jan 07, 2014 at 07:21:03PM -0600, Scott Wood wrote:
> On Sat, 2014-01-04 at 11:15 -0800, Guenter Roeck wrote:
> > On Mon, Dec 09, 2013 at 04:03:10PM +1100, Anton Blanchard wrote:
> > > ehv_bytechan is marked tristate but fails to build as a module:
> > > 
> > > drivers/tty/ehv_bytechan.c:363:1: error: type defaults to ‘int’ in declaration of ‘console_initcall’ [-Werror=implicit-int]
> > > 
> > > It doesn't make much sense for a console driver to be built as
> > > a module, so change it to a bool.
> > > 
> > > Signed-off-by: Anton Blanchard <anton@samba.org>
> > > 
> > 
> > Any comments on this patch ? The problem still causes powerpc:allmodconfig to
> > fail.
> 
> It's fine with me...
> 
> Greg, are you going to take this via tty.git or do you want it to go via
> PPC?

Feel free to take it through PPC.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

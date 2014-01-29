Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 752DF2C0078
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jan 2014 18:46:32 +1100 (EST)
Message-ID: <1390981569.8524.53.camel@pasglop>
Subject: Re: Please pull 'next' branch of 5xxx tree
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Anatolij Gustschin <agust@denx.de>
Date: Wed, 29 Jan 2014 18:46:09 +1100
In-Reply-To: <1390888814.8524.13.camel@pasglop>
References: <20140115221859.50866e87@crub> <20140128064614.511d36be@crub>
 <1390888814.8524.13.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-01-28 at 17:00 +1100, Benjamin Herrenschmidt wrote:
> On Tue, 2014-01-28 at 06:46 +0100, Anatolij Gustschin wrote:
> > Hi Ben !
> > 
> > On Wed, 15 Jan 2014 22:18:59 +0100
> > Anatolij Gustschin <agust@denx.de> wrote:
> > 
> > > Hi Ben !
> > > 
> > > please pull mpc5xxx patches for v3.14:
> > 
> > Ping.
> 
> Oops, you sent that while I was on vacation and I missed it.
> 
> Next time, try to send your pull request earlier if possible, I'd like
> to have most stuff together before -rc5. I'll try to send this one to
> Linus after he has pulled my current one.

Hrm, I get a merge conflicts with spi-mpc512x-psc.c, please check that I
fixed it up properly in powerpc-next and let me know.

If it's good I'll send to Linus tomorrow.

Cheers,
Ben.

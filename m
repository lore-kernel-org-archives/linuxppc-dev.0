Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id EB2372C0089
 for <linuxppc-dev@ozlabs.org>; Tue,  2 Jul 2013 20:29:20 +1000 (EST)
Message-ID: <1372760942.4122.2.camel@pasglop>
Subject: Re: Please pull 'next' branch of 5xxx tree
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Anatolij Gustschin <agust@denx.de>
Date: Tue, 02 Jul 2013 20:29:02 +1000
In-Reply-To: <20130702100036.4610a0ae@crub>
References: <20130702003605.2838c666@crub> <1372751161.3616.1.camel@pasglop>
 <20130702100036.4610a0ae@crub>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2013-07-02 at 10:00 +0200, Anatolij Gustschin wrote:
> On Tue, 02 Jul 2013 17:46:01 +1000
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> 
> > On Tue, 2013-07-02 at 00:36 +0200, Anatolij Gustschin wrote:
> > > Hi Ben !
> > > 
> > > Please pull mpc5xxx patches for v3.11. There are small cleanups
> > > and fixes for mpc512x common code, mpc512x_defconfig updates and
> > > soft reboot support for mpc5125 based boards.
> > 
> > Looks like your server is down...
> 
> The server should be up, a recent test pull succeeded here. Could you
> please try again?

Just a fluke indeed, works now. Pulled & pushed.

Cheers,
Ben.

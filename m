Return-Path: <joe@perches.com>
Message-ID: <1357837252.2894.6.camel@joe-AO722>
Subject: Re: [TRIVIAL PATCH 11/26] powerpc: Convert print_symbol to %pSR
From: Joe Perches <joe@perches.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 10 Jan 2013 09:00:52 -0800
In-Reply-To: <1357796898.4838.85.camel@pasglop>
References: <cover.1355335227.git.joe@perches.com>
 <8c901014a0f571011023ed98b9a22bc690925b73.1355335228.git.joe@perches.com>
 <201212131158.46055.arnd@arndb.de> <1357796898.4838.85.camel@pasglop>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Cc: cbe-oss-dev@lists.ozlabs.org, Jiri Kosina <trivial@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-01-10 at 16:48 +1100, Benjamin Herrenschmidt wrote:
> On Thu, 2012-12-13 at 11:58 +0000, Arnd Bergmann wrote:
> > On Wednesday 12 December 2012, Joe Perches wrote:
> > > Use the new vsprintf extension to avoid any possible
> > > message interleaving.
> > > 
> > > Convert the #ifdef DEBUG block to a single pr_debug.
> > > 
> > > Signed-off-by: Joe Perches <joe@perches.com>
> > 
> > nice cleanup!
> 
>  ... which also breaks the build :-(
> 
> > Acked-by: Arnd Bergmann <arnd@arndb.de>
> 
> I'll fix it up locally.

OK, I didn't compile it.
How does it break the build?

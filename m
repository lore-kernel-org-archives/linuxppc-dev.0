Return-Path: <benh@kernel.crashing.org>
Message-ID: <1372974938.4122.103.camel@pasglop>
Subject: Re: [PATCH] of: Fix address decoding on Bimini and js2x machines
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Grant Likely <grant.likely@linaro.org>
Date: Fri, 05 Jul 2013 07:55:38 +1000
In-Reply-To: <20130704161828.EB08D3E08D0@localhost>
References: <1372831270.4122.36.camel@pasglop> <51D430C7.8030100@gmail.com>
 <CACxGe6ucVocguyNdZ9CiN0ef=WgmOrZe0FyVij_bC7bJZe41=g@mail.gmail.com>
 <20130704161828.EB08D3E08D0@localhost>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 devicetree-discuss <devicetree-discuss@lists.ozlabs.org>,
 Thierry Reding <thierry.reding@avionic-design.de>,
 Rob Herring <robherring2@gmail.com>, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-07-04 at 17:18 +0100, Grant Likely wrote:
> > I'll include this in my 3.11 pull request for Linus
> 
> Oops. Ben, I misread what you wrote. It would have been just fine to
> include it in your powerpc -next branch. Sorry for the confusion.
> 
> Anyway, I saw your powerpc pull req and that this patch wasn't in it, so
> I've picked it up and will send it to Linus as soon as the test build
> completes.

Yeah, I was about to add it to a subsequent "fixes" branch but since you
picked it up I'll just leave it.

Thanks !

Cheers,
Ben.
 

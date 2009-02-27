Return-Path: <davem@davemloft.net>
Date: Fri, 27 Feb 2009 03:18:57 -0800 (PST)
Message-Id: <20090227.031857.240013447.davem@davemloft.net>
To: afleming@gmail.com
Subject: Re: [PATCH v2 net] gianfar : Do right check on num_txbdfree
From: David Miller <davem@davemloft.net>
In-Reply-To: <2acbd3e40902261407w7e92dbe0u4dd008b3e6b239a2@mail.gmail.com>
References: <20090226.020318.50178027.davem@davemloft.net>
	<49A66E2D.3060204@arvoo.nl>
	<2acbd3e40902261407w7e92dbe0u4dd008b3e6b239a2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: Linuxppc-dev@ozlabs.org, rini@arvoo.nl, afleming@freescale.com,
	netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Andy Fleming <afleming@gmail.com>
Date: Thu, 26 Feb 2009 16:07:16 -0600

> On Thu, Feb 26, 2009 at 4:25 AM, Rini van Zetten <rini@arvoo.nl> wrote:
> > This patch fixes a wrong check on num_txbdfree. It could lead to
> > num_txbdfree become nagative.
> > Result was that the gianfar stops sending data.
> >
> > Changes from first version :
> > - removed a space between parens (David Millers comment)
> > - full email address in signed off line
> >
> >
> > Signed-off-by: Rini van Zetten <rini@arvoo.nl>
> 
> Good catch.  Does this solve the bug you reported earlier?
> 
> Acked-by: Andy Fleming <afleming@freescale.com>

Applied, thanks.

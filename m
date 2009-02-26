Return-Path: <davem@davemloft.net>
Date: Thu, 26 Feb 2009 02:03:18 -0800 (PST)
Message-Id: <20090226.020318.50178027.davem@davemloft.net>
To: rini@arvoo.nl
Subject: Re: [PATCH net] gianfar : Do right check on num_txbdfree
From: David Miller <davem@davemloft.net>
In-Reply-To: <49A6595A.9000405@arvoo.nl>
References: <49A6595A.9000405@arvoo.nl>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: Linuxppc-dev@ozlabs.org, afleming@freescale.com, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Rini van Zetten <rini@arvoo.nl>
Date: Thu, 26 Feb 2009 09:56:58 +0100

> This patch fixes a wrong check on num_txbdfree. It could lead to
> num_txbdfree become nagative.  Result was that the gianfar stops
> sending data.
> 
> Signed-off-by: Rini van Zetten <rini at arvoo dot nl

Please use rini@arvoo.nl in your signoffs, you cannot
hide on the inna-net.

> -	if (nr_frags > priv->num_txbdfree) {
> +	if ( (nr_frags+1) > priv->num_txbdfree) {

Please don't put a space between the parens there "( (", like
that.

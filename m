Return-Path: <afleming@gmail.com>
MIME-Version: 1.0
In-Reply-To: <49A66E2D.3060204@arvoo.nl>
References: <49A6595A.9000405@arvoo.nl>
	<20090226.020318.50178027.davem@davemloft.net>
	<49A66E2D.3060204@arvoo.nl>
Date: Thu, 26 Feb 2009 16:07:16 -0600
Message-ID: <2acbd3e40902261407w7e92dbe0u4dd008b3e6b239a2@mail.gmail.com>
Subject: Re: [PATCH v2 net] gianfar : Do right check on num_txbdfree
From: Andy Fleming <afleming@gmail.com>
To: Rini van Zetten <rini@arvoo.nl>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linuxppc-dev@ozlabs.org, afleming@freescale.com,
	David Miller <davem@davemloft.net>, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Feb 26, 2009 at 4:25 AM, Rini van Zetten <rini@arvoo.nl> wrote:
> This patch fixes a wrong check on num_txbdfree. It could lead to
> num_txbdfree become nagative.
> Result was that the gianfar stops sending data.
>
> Changes from first version :
> - removed a space between parens (David Millers comment)
> - full email address in signed off line
>
>
> Signed-off-by: Rini van Zetten <rini@arvoo.nl>

Good catch.  Does this solve the bug you reported earlier?

Acked-by: Andy Fleming <afleming@freescale.com>

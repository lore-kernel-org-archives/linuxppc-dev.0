Return-Path: <Geert.Uytterhoeven@sonycom.com>
Date: Thu, 26 Feb 2009 17:03:03 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Rini van Zetten <rini@arvoo.nl>
Subject: Re: [PATCH v2 net] gianfar : Do right check on num_txbdfree
In-Reply-To: <49A66E2D.3060204@arvoo.nl>
Message-ID: <alpine.LRH.2.00.0902261701530.6201@vixen.sonytel.be>
References: <49A6595A.9000405@arvoo.nl>
	<20090226.020318.50178027.davem@davemloft.net>
	<49A66E2D.3060204@arvoo.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
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

On Thu, 26 Feb 2009, Rini van Zetten wrote:
> This patch fixes a wrong check on num_txbdfree. It could lead to num_txbdfree
> become nagative.
> Result was that the gianfar stops sending data.

A quick mental note for your next patch submission:

> Changes from first version :
> - removed a space between parens (David Millers comment)
> - full email address in signed off line

Changelogs since previous versions should be ...

> Signed-off-by: Rini van Zetten <rini@arvoo.nl>
> ---

... here, below the `---', as they're not supposed to be end up in the final
commit message.

>  drivers/net/gianfar.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

With kind regards,

Geert Uytterhoeven
Software Architect

Sony Techsoft Centre Europe
The Corporate Village · Da Vincilaan 7-D1 · B-1935 Zaventem · Belgium

Phone:    +32 (0)2 700 8453
Fax:      +32 (0)2 700 8622
E-mail:   Geert.Uytterhoeven@sonycom.com
Internet: http://www.sony-europe.com/

A division of Sony Europe (Belgium) N.V.
VAT BE 0413.825.160 · RPR Brussels
Fortis · BIC GEBABEBB · IBAN BE41293037680010

Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 70D29DDEC0
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Oct 2007 02:27:58 +1000 (EST)
Date: Wed, 3 Oct 2007 20:29:00 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH v3] qe: miscellaneous code improvements and fixes to
	the QE library
Message-ID: <20071003162900.GA30091@localhost.localdomain>
References: <11903212461510-git-send-email-timur@freescale.com>
	<20071003133032.GA2417@localhost.localdomain>
	<4703A453.8080305@freescale.com>
	<20071003143417.GA5123@localhost.localdomain>
	<4703AEDC.1050902@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <4703AEDC.1050902@freescale.com>
Cc: linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Oct 03, 2007 at 10:01:48AM -0500, Timur Tabi wrote:
> Anton Vorontsov wrote:
>
>> Ok, thanks anyway, will look further as time will permit.
>
> I think I found it.  Of course, if I'm right, then that doesn't explain how 
> the 8360 works.
>
> In struct ucc_geth, add this:
>
>  struct ucc_geth {
>  	struct ucc_fast uccf;
> +	u8	res9[0x100 - sizeof(struct ucc_fast)];
>  	u32 maccfg1;		/* mac configuration reg. 1 */
>  	u32 maccfg2;		/* mac configuration reg. 2 */
>

This fixed issue, much thanks.

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2

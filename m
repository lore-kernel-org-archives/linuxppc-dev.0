Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 37A372BDC5
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Sep 2004 21:00:03 +1000 (EST)
To: "Robert P. J. Day" <rpjday@mindspring.com>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 21 Sep 2004 06:13:14 EDT."
	<Pine.LNX.4.60.0409210605090.9033@dell.enoriver.com>
Date: Tue, 21 Sep 2004 12:40:29 +0200
Sender: wd@denx.de
Message-Id: <20040921104034.6DCA0C108D@atlas.denx.de>
Cc: Linuxppc-dev mailing list <linuxppc-dev@ozlabs.org>
Subject: Re: thoughts and questions on 8xx patches 
List-Id: "Linux on PowerPC \(Including Embedded\) Developers Mail List"
	<linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In message <Pine.LNX.4.60.0409210605090.9033@dell.enoriver.com> you wrote:
> 
>    rather than get into more detailed discussion on microcode patches, 
> here's a (partial) patch that represents what i'd really, really, 
> *really* like to see.
...
> +config I2C_SPI_PATCH
> +	bool "I2C/SPI relocation patch"
> +
> +config I2C_SPI_SMC1_PATCH
> +	bool "I2C/SPI/SMC1 relocation patch"

Why? As far as I understand the I2C/SPI patch has been obsolteted  by
the I2C/SPI/SMC1 patch. So only the latter is needed.

>    it adds a simple choice entry to the MPC8xx menu, from which you can 
> select the appropriate patch -- it's as easy as that.

No, it is not that easy.

>    note that that's not the entire list of possible patches -- i have 
> the list from wolfgang's tree that distinguishes between 850 and 8xx 
> (non-850) patches in some cases so the list is actually longer than 
> this one.  but, really, selecting a patch should be this easy -- pick 

Indeed. And AFAICT there is no way to get the processor version  from
any  other CONFIG option that the board name, so this would become an
awfully long list.

> one and check the box.  and this makes it trivial to add or delete 
> patches appropriately as time goes by.
> 
>    obviously, this menu requires changes in the underlying micropatch.c 
> file (which aren't shown here), but i'm curious about whether this 
> approach would overly offend anyone.

This has been discussed many times before. 

>    i'm willing to create the overall patch to support this, but not if 
> it's just going to be tossed because of philosophical positions.

It's technical issues, too. There was a decision not to configure for
a specific variant of the 8xx processor, and so it becomes cumbersome
to add "convenient" configuration options  which  depend  on  exactly
this information.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Do you suppose the reason the ends of the `Intel Inside'  logo  don't
match up is that it was drawn on a Pentium?

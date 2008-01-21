Return-Path: <david-b@pacbell.net>
Received: from smtp117.sbc.mail.sp1.yahoo.com (smtp117.sbc.mail.sp1.yahoo.com
	[69.147.64.90]) by ozlabs.org (Postfix) with SMTP id 6E640DDECE
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jan 2008 07:51:05 +1100 (EST)
From: David Brownell <david-b@pacbell.net>
To: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: [patch v4 0/4] Cypress c67x00 (EZ-Host/EZ-OTG) support
Date: Mon, 21 Jan 2008 12:51:02 -0800
References: <20080121103434.397382000@sunsite.dk>
	<fa686aa40801210911q4ce90816tebafa46e68a3f980@mail.gmail.com>
	<87zluz0w9g.fsf@macbook.be.48ers.dk>
In-Reply-To: <87zluz0w9g.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200801211251.02288.david-b@pacbell.net>
Cc: linuxppc-dev@ozlabs.org, linux-usb@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 21 January 2008, Peter Korsgaard wrote:
> Sure, http://peter.korsgaard.com/c67x00-v3-v4.patch (not posting as
> it's more than 100k)

I like this bit:

> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3832,6 +3832,12 @@ L:      linux-usb@vger.kernel.org
>  S:     Maintained
>  W:     http://www.kroah.com/linux-usb/
>
> +USB CYPRESS C67X00 DRIVER
> +P:     Peter Korsgaard
> +M:     jacmet@sunsite.dk
> +L:     linux-usb@vger.kernel.org
> +S:     Maintained
> +
>  USB DAVICOM DM9601 DRIVER
>  P:     Peter Korsgaard
>  M:     jacmet@sunsite.dk

:)

Grant, please let us know if you see anything to object to in
this "v4" patch (parts 1..3 only).  At a quick glance, I didn't
see any ... other than stuff associated with peripheral mode
support, which isn't yet proposed for merging.  So for the
moment it looks like v4 is the one to review (and maybe merge).

- Dave

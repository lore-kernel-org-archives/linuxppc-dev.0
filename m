Return-Path: <jonsmirl@gmail.com>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.237])
	by ozlabs.org (Postfix) with ESMTP id 71ED2DDE29
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Nov 2007 06:26:22 +1100 (EST)
Received: by nz-out-0506.google.com with SMTP id i1so263750nzh
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Nov 2007 11:26:20 -0800 (PST)
Message-ID: <9e4733910711141126k1bb896caoe40fb7204237fa85@mail.gmail.com>
Date: Wed, 14 Nov 2007 14:26:19 -0500
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Scott Wood" <scottwood@freescale.com>
Subject: Re: I2C on mpc8248 / device tree
In-Reply-To: <20071114175630.GA4547@loki.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <bfa0697f0711131539n228f9f21q7b2acc896499b80d@mail.gmail.com>
	<9e4733910711131556r23a38780q39baf15d85c0bd85@mail.gmail.com>
	<bfa0697f0711140731n20ccd8bdme2de6302848f5a4f@mail.gmail.com>
	<9AADA2CE-A7F0-4C88-BFCF-08D6C8DC09E0@kernel.crashing.org>
	<bfa0697f0711140949q4cf92442gcb4c1ecf7592b040@mail.gmail.com>
	<20071114175630.GA4547@loki.buserror.net>
Cc: linuxppc-dev@ozlabs.org, Alan Bennett <embedded@akb.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 11/14/07, Scott Wood <scottwood@freescale.com> wrote:
> On Wed, Nov 14, 2007 at 10:49:13AM -0700, Alan Bennett wrote:
> > ERk.
> >   So if I needed to read values from four i2c devices (raw access would be
> > fine) and I need to get this working in a few days, how would you suggest I
> > proceed?  Kernel = 2.6.23+.
> >
> >   Do I need to start from scratch?
> >
> >   Start by using Jon's patch  (or are the 5200 i2c and the cpm2 i2c
> > completely incompatible?)
>
> Start with the cpm i2c driver that Jochen Friedrich posted to
> linuxppc-embedded.

Sorry about the confusion I thought the mpc82xx chips had the same i2c
core as the mpc52xx but I was not correct.


>
> -Scott
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>


-- 
Jon Smirl
jonsmirl@gmail.com

Return-Path: <glikely@secretlab.ca>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A6BB8B711F
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 21 Jan 2011 16:44:36 +1100 (EST)
Received: by iwb12 with SMTP id 12so1465964iwb.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 20 Jan 2011 21:44:33 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1295576122.2148.271.camel@pasglop>
References: <1295576122.2148.271.camel@pasglop>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 20 Jan 2011 22:44:13 -0700
Message-ID: <AANLkTi=V1ysEOLWpV1ubSwG=QpAshHJbVLf7+=h+-51h@mail.gmail.com>
Subject: Re: of_flat_dt_match() helper build FAIL
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jan 20, 2011 at 7:15 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> a4f740cf33f7f6c164bbde3c0cdbcc77b0c4997c introduces:
>
> /arch/powerpc/platforms/83xx/mpc831x_rdb.c:63: error: expected '{'
> before 'const'
>
> =A0and more...
>
> This hunk is obviously bogus:
>
> +struct const char *board[] __initdata =3D {
> + =A0 =A0 =A0 "MPC8313ERDB",
> + =A0 =A0 =A0 "fsl,mpc8315erdb",
> + =A0 =A0 =A0 NULL
> +}
> +
>
> You should at least compile test your changes :-(

I do.  Always.  Over Christmas I even set up an autotest instance to
automate a bunch of the sanity testing so I'd get better coverage, and
I always get changes into linux-next, this commit included. Sometimes
I miss a configuration though, and I apologize.  Sorry.

> Please send Linus a fix.

I wrote and pushed out the fix yesterday and I just sent Linus the pull req=
.

g.

Return-Path: <tmarri@apm.com>
Received: from exprod5og110.obsmtp.com (exprod5og110.obsmtp.com [64.18.0.20])
	by ozlabs.org (Postfix) with SMTP id D09FAB70A4
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 10 Dec 2010 03:45:07 +1100 (EST)
Received: by mail-qw0-f48.google.com with SMTP id 6so2870356qwh.35
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 09 Dec 2010 08:45:04 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20101209064737.GA10820@kroah.com>
References: <1291854539-23879-1-git-send-email-tmarri@apm.com>
	<20101209064737.GA10820@kroah.com>
Date: Thu, 9 Dec 2010 08:45:04 -0800
Message-ID: <AANLkTi=TWnj0VmH78j2T=7qkavJGYGBh9wws6nfTYKdF@mail.gmail.com>
Subject: Re: [PATCH V6 00/10] Add-Synopsys-DesignWare-HS-USB-OTG-driver
From: Tirumala Marri <tmarri@apm.com>
To: Greg KH <greg@kroah.com>
Content-Type: multipart/alternative; boundary=0016364ee5d4a909d10496fcf539
Cc: linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--0016364ee5d4a909d10496fcf539
Content-Type: text/plain; charset=ISO-8859-1

Yes please.
Regards,
Marri

On Wed, Dec 8, 2010 at 10:47 PM, Greg KH <greg@kroah.com> wrote:

> On Wed, Dec 08, 2010 at 04:28:59PM -0800, tmarri@apm.com wrote:
> > From: Tirumala Marri <tmarri@apm.com>
> >
> > v6:
> >  1. Replaced register definitions and bit fields with macros.
> >  2. Replace printks with dev_dbg or dev_err functions.
> >  3. Cleanup some assignments.
> >  4. Remove chip specific selections in Kconfig file.
>
> Much nicer, thanks.
>
> Do you wish for me to apply this to the tree if it passes review?
>
> thanks,
>
> greg k-h
>

--0016364ee5d4a909d10496fcf539
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Yes please.<div>Regards,</div><div>Marri<br><br><div class=3D"gmail_quote">=
On Wed, Dec 8, 2010 at 10:47 PM, Greg KH <span dir=3D"ltr">&lt;<a href=3D"m=
ailto:greg@kroah.com">greg@kroah.com</a>&gt;</span> wrote:<br><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;=
padding-left:1ex;">
<div class=3D"im">On Wed, Dec 08, 2010 at 04:28:59PM -0800, <a href=3D"mail=
to:tmarri@apm.com">tmarri@apm.com</a> wrote:<br>
&gt; From: Tirumala Marri &lt;<a href=3D"mailto:tmarri@apm.com">tmarri@apm.=
com</a>&gt;<br>
&gt;<br>
&gt; v6:<br>
&gt; =A01. Replaced register definitions and bit fields with macros.<br>
&gt; =A02. Replace printks with dev_dbg or dev_err functions.<br>
&gt; =A03. Cleanup some assignments.<br>
&gt; =A04. Remove chip specific selections in Kconfig file.<br>
<br>
</div>Much nicer, thanks.<br>
<br>
Do you wish for me to apply this to the tree if it passes review?<br>
<br>
thanks,<br>
<br>
greg k-h<br>
</blockquote></div><br></div>

--0016364ee5d4a909d10496fcf539--

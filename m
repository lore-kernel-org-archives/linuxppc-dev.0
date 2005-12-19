Return-Path: <addison.baldwin@gmail.com>
Received: from xproxy.gmail.com (xproxy.gmail.com [66.249.82.198])
	by ozlabs.org (Postfix) with ESMTP id A6481688D6
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 19 Dec 2005 23:17:54 +1100 (EST)
Received: by xproxy.gmail.com with SMTP id i27so774275wxd
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 19 Dec 2005 04:17:52 -0800 (PST)
Message-ID: <af313df20512190417vb0cb57bm48b5a8e9b4c9db6f@mail.gmail.com>
Date: Mon, 19 Dec 2005 12:17:52 +0000
From: Addison Baldwin <addison.baldwin@gmail.com>
To: Vitaly Bordug <vbordug@ru.mvista.com>
In-Reply-To: <43A31EE1.3030101@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <af313df20512161201u39280d30kdf1ace1c4569d50a@mail.gmail.com>
	<43A31EE1.3030101@ru.mvista.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Unable to open an initial console
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Thank you!

I had to create the /dev/ttyCPM0 and had to point /dev/console to it.
Now the console is working fine!

Best Regards,
Addison Baldwin

On 12/16/05, Vitaly Bordug <vbordug@ru.mvista.com> wrote:
> Addison Baldwin wrote:
> > I was sucessful to port U-Boot to our 8272 board. Now I'm experiencing
> > a problem:
> >
> > Our Kernel hangs with the message that says it was trasnferring
> > control to linux. A post morten analyzes indicated that it stopped at
> > "Unable to open an initial console" in the memory sapce where console
> > output should be out (in the sdram, like I had found somewhere in this
> > list, how to do it).
> >
> > I have checked the bootargs values, it is ok:
> > bootargs root=3D/dev/ram console=3DttyS0,115200
> >
> Only for 2.4, 2.6 is different for this.
> console=3DttyCPM0 should be there, and that device does have different ma=
jor/minor comparing to ttyS0.
> Note that the UART has to be enabled explicitly in kernel config, for mor=
e info, search this list archives.
>
> >  We also checked our "/dev" and there was a link to console, pointing
> > ttyS0. Also, ttyS0 was there too.
> >
> > Does anyone have any idea how to fix it?
> > _______________________________________________
> > Linuxppc-embedded mailing list
> > Linuxppc-embedded@ozlabs.org
> > https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> >
> >
>
>
> --
> Sincerely,
> Vitaly
>

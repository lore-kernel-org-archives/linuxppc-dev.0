Return-Path: <johns.daniel@gmail.com>
Received: from qw-out-2122.google.com (qw-out-2122.google.com [74.125.92.25])
	by ozlabs.org (Postfix) with ESMTP id 04C3EDE00A
	for <linuxppc-dev@ozlabs.org>; Sat, 24 Jan 2009 04:38:12 +1100 (EST)
Received: by qw-out-2122.google.com with SMTP id 9so1183965qwb.15
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Jan 2009 09:38:10 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4979EE74.6040306@freescale.com>
References: <ba5d9360901230705v750a958au7eeaa923aadc41ad@mail.gmail.com>
	<4979EE74.6040306@freescale.com>
Date: Fri, 23 Jan 2009 11:31:05 -0600
Message-ID: <ba5d9360901230931o20611d59hafdfb555209e255c@mail.gmail.com>
Subject: Re: Common kernel image for e300 and e500v2
From: Johns Daniel <johns.daniel@gmail.com>
To: linuxppc-dev@ozlabs.org
Content-Type: multipart/alternative; boundary=0015175caadaf5e247046129c044
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--0015175caadaf5e247046129c044
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Thank you for that piece of info, Scott!

May I expand the question one bit, and ask whether the user-mode binaries
compiled for the e300 will generally work for the e500 -- or, vice versa? Is
one choice safer than the other?

I know for sure that we take a big hit on floating-point ops, but are there
other things I am not considering?

-- Johns

On Fri, Jan 23, 2009 at 10:21 AM, Scott Wood <scottwood@freescale.com>wrote:

> Johns Daniel wrote:
>
>> Is it possible -- and prudent -- to use a single kernel binary image
>> for two similar boards, one based on an e300 core and the other on an
>> e500v2 core?
>>
>
> No, it is not possible.  They use different MMUs, and the kernel does not
> support choosing between them at runtime.
>
>  I was surprised to see that the e500v2-targeted toolchain did build
>> the kernel for the e300 board just fine. Don't know whether this will
>> always be true?
>>
>
> "always" is a strong word, but it should generally work.
>
> -Scott
>
>

--0015175caadaf5e247046129c044
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Thank you for that piece of info, Scott!<br><br>May I expand the question o=
ne bit, and ask whether the user-mode binaries compiled for the e300 will g=
enerally work for the e500 -- or, vice versa? Is one choice safer than the =
other?<br>

<br>I know for sure that we take a big hit on floating-point ops, but are t=
here other things I am not considering?<br><br>-- Johns<br><br><div class=
=3D"gmail_quote">On Fri, Jan 23, 2009 at 10:21 AM, Scott Wood <span dir=3D"=
ltr">&lt;<a href=3D"mailto:scottwood@freescale.com" target=3D"_blank">scott=
wood@freescale.com</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div>Johns Daniel=
 wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Is it possible -- and prudent -- to use a single kernel binary image<br>
for two similar boards, one based on an e300 core and the other on an<br>
e500v2 core?<br>
</blockquote>
<br></div>
No, it is not possible. &nbsp;They use different MMUs, and the kernel does =
not support choosing between them at runtime.<div><br>
<br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
I was surprised to see that the e500v2-targeted toolchain did build<br>
the kernel for the e300 board just fine. Don&#39;t know whether this will<b=
r>
always be true?<br>
</blockquote>
<br></div>
&quot;always&quot; is a strong word, but it should generally work.<br><font=
 color=3D"#888888">
<br>
-Scott<br>
<br>
</font></blockquote></div><br>

--0015175caadaf5e247046129c044--

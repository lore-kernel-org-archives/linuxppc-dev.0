Return-Path: <fabien.fb@gmail.com>
Received: from mu-out-0910.google.com (mu-out-0910.google.com [209.85.134.185])
	by ozlabs.org (Postfix) with ESMTP id 7ACF0DDE1C
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 24 Nov 2007 02:08:49 +1100 (EST)
Received: by mu-out-0910.google.com with SMTP id w1so3773571mue
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 23 Nov 2007 07:08:48 -0800 (PST)
Message-ID: <f8f856500711230708k4dbc3ca6wdaa5d1d4a355430f@mail.gmail.com>
Date: Fri, 23 Nov 2007 16:08:47 +0100
From: fabien <fabien.fb@gmail.com>
To: "Wolfgang Denk" <wd@denx.de>
Subject: Re: cant' compile busybox-1.8.1 with eldk 4.1
In-Reply-To: <20071123144834.77D1A246B5@gemini.denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <f8f856500711230439q39c352ffi4cf3a206de68733a@mail.gmail.com>
	<20071123144834.77D1A246B5@gemini.denx.de>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

2007/11/23, Wolfgang Denk <wd@denx.de>:
> In message <f8f856500711230439q39c352ffi4cf3a206de68733a@mail.gmail.com> you wrote:
> > Thanks Clemens i've opened a thread in busybox mailing list :
> > http://www.busybox.net/lists/busybox/2007-November/029322.html
>
> Actually you should have asked this on the LDK mailing list instead,
> see http://lists.denx.de/mailman/listinfo/eldk
>
> But before posting, you should have read the FAQ, especially
> http://www.denx.de/wiki/view/DULG/ELDKIncludeFilesMissing
>
> Best regards,
>
> Wolfgang Denk
>
> --
> DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
> If the hours are long enough and the pay  is  short  enough,  someone
> will say it's women's work.
>
Thanks Wolfgang
i've just seen this and it's seem work !

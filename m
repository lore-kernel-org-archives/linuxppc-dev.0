Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.171])
	by ozlabs.org (Postfix) with ESMTP id C1CB467B7F
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 15 Jul 2006 00:27:55 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id j3so744505ugf
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 14 Jul 2006 07:27:53 -0700 (PDT)
Message-ID: <528646bc0607140727h1cd559b4yff575369caa2c7d1@mail.gmail.com>
Date: Fri, 14 Jul 2006 08:27:53 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Robert Zach so-logic" <rza1@so-logic.co.at>
Subject: Re: native gcc for ml403(ppc405)
In-Reply-To: <1397A8F2-0E9E-40B9-AB4B-132C30C09F25@so-logic.co.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <1397A8F2-0E9E-40B9-AB4B-132C30C09F25@so-logic.co.at>
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

On 7/14/06, Robert Zach so-logic <rza1@so-logic.co.at> wrote:
>
> Hello!
>
> I am working on a ml403 with virtex 4 (ppc405).
> I have build me a crosscompiler and  a glibc with crosstool.
> This worked very good for me...(i can compile 2.4 and 2.6 kernel...)
>
> Now i would like to build a native compiler for the ppc405...(I need a
> native compiler for a few things that are hard to crosscompile.)
>
> Is it possible to compile the binutils and gcc with my crosscompiler to get
> a native compiler??

Yes it is. You can cross compile gcc just like any other package.
It's a little complex, but it's been done many times.

You might want to take a look at the buildroot tool to see an example.

Cheers,
g.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195

Return-Path: <glikely@secretlab.ca>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179]) by ozlabs.org (Postfix) with ESMTP id 118371007D2
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  7 Aug 2010 12:54:55 +1000 (EST)
Received: by gya1 with SMTP id 1so3355485gya.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 06 Aug 2010 19:54:54 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20100807100123.886d3a1e.sfr@canb.auug.org.au>
References: <20100806183839.32149.6238.stgit@angua>
	<20100807100123.886d3a1e.sfr@canb.auug.org.au>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 6 Aug 2010 20:54:34 -0600
Message-ID: <AANLkTikt5xR0jYL_m6+vO2bkcxSBA8DwffRDbDae8OmA@mail.gmail.com>
Subject: Re: [PATCH] powerpc: fix i8042 module build error
To: Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset=ISO-8859-1
Cc: martyn.welch@ge.com, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Aug 6, 2010 at 6:01 PM, Stephen Rothwell <sfr@canb.auug.org.au> wro=
te:
> Hi Grant,
>
> On Fri, 06 Aug 2010 12:42:12 -0600 Grant Likely <grant.likely@secretlab.c=
a> wrote:
>>
>> of_i8042_{kbd,aux}_irq needs to be exported
>>
>> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
>> ---
>>
>> Stephen and Ben, this fixes up the build error in linux-next. =A0If you =
prefer,
>> I can stuff this patch into my next-powerpc branch. =A0Ben, I've got oth=
er
>> commits in that branch that I'll be sending to you early next week anywa=
y.
>
> This failure also exists in Linus' tree, so the earlier this goes to
> Linus the better.

Okay then.  Ben, I'll send out my pull request out right away so
you've got it if you want to use it.

Cheers,
g.
> --
> Cheers,
> Stephen Rothwell =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sfr@canb.auug.org=
.au
> http://www.canb.auug.org.au/~sfr/
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

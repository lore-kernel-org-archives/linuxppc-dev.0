Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.170])
	by ozlabs.org (Postfix) with ESMTP id BAECC67D51
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Oct 2006 17:23:47 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id 30so754583ugc
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Oct 2006 00:23:45 -0700 (PDT)
Message-ID: <528646bc0610280023j266b479fjd5e5e7d2f2118720@mail.gmail.com>
Date: Sat, 28 Oct 2006 01:23:45 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Johannes Berg" <johannes@sipsolutions.net>
Subject: Re: Is get_property() correct?
In-Reply-To: <1162019855.14051.15.camel@johannes.berg>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <528646bc0610272341s3c655ebbn785b373f148f6174@mail.gmail.com>
	<1162019855.14051.15.camel@johannes.berg>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Bah!  Wack me with the cluestick.  I've got temporary dyslexia tonight.

Sorry.

On 10/28/06, Johannes Berg <johannes@sipsolutions.net> wrote:
>
> > The comment says it
> > returns the value of a property
>
> >  * and return the value.
>
> >         return pp ? pp->value : NULL;
>
> ...? Looks like the value to me, unless the property doesn't exist.
>
> johannes
>
>
>


-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195

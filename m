Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.172])
	by ozlabs.org (Postfix) with ESMTP id D325167D43
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Oct 2006 17:38:20 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id 30so755225ugc
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Oct 2006 00:38:18 -0700 (PDT)
Message-ID: <528646bc0610280038x421014bdxde263c5399907fcb@mail.gmail.com>
Date: Sat, 28 Oct 2006 01:38:18 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
Subject: Re: Is get_property() correct?
In-Reply-To: <1162020235.25682.124.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <528646bc0610272341s3c655ebbn785b373f148f6174@mail.gmail.com>
	<1162020235.25682.124.camel@localhost.localdomain>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 10/28/06, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> On Sat, 2006-10-28 at 00:41 -0600, Grant Likely wrote:
>
> Well considering that we don't know the type of the property value, the
> best we can do is return a pointer to it ...
>
> The comment might want an update, though it never stroke me as confusing
> but heh :)

No, it's not confusing.  Both the comment and the code are correct.  I
just forgot how to read code.  :(

g.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195

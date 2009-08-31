Return-Path: <stuyoder@gmail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 43B8BB7B75
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  1 Sep 2009 03:49:05 +1000 (EST)
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.249])
	by ozlabs.org (Postfix) with ESMTP id A578BDDD04
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Sep 2009 03:49:04 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id b6so1686809ana.39
	for <linuxppc-dev@ozlabs.org>; Mon, 31 Aug 2009 10:49:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <fa686aa40908281309g6eedcdb4neb6a96104807a3f1@mail.gmail.com>
References: <1250569288.19007.15.camel@pasglop>
	<1251411532.20467.74.camel@pasglop> <4A970C85.8090703@firmworks.com>
	<1251420686.20467.96.camel@pasglop> <4A974295.9020504@firmworks.com>
	<1251427388.20467.122.camel@pasglop>
	<955e48b80908280516m457530cfn3b07b52f2fa2c471@mail.gmail.com>
	<fa686aa40908280906w7953017ek44ee498d57e0a642@mail.gmail.com>
	<955e48b80908281105q60c057e8pfc16213f17da9138@mail.gmail.com>
	<fa686aa40908281309g6eedcdb4neb6a96104807a3f1@mail.gmail.com>
Date: Mon, 31 Aug 2009 12:49:02 -0500
Message-ID: <955e48b80908311049p4a08e683q3a23239b3307f502@mail.gmail.com>
Subject: Re: [RFC] Clock binding
From: Stuart Yoder <stuyoder@gmail.com>
To: Grant Likely <grant.likely@secretlab.ca>
Content-Type: text/plain; charset=ISO-8859-1
Cc: devicetree-discuss@lists.ozlabs.org,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> How about right here: =A0http://fdt.secretlab.ca/
>
> I've only just created the site. =A0I'll fill in some documentation and
> structure in the next few days. =A0Feel free to create an account and
> start adding stuff.
>
> We'll need to talk about how best to manage bindings and have some
> form of review/agreement before a binding is marked as "stable". =A0And
> the site URL could change as well. =A0But in the meantime we've got a
> sandbox to start playing in.

Unless there are better suggestions, your site is fine with me.

One other thing-- we need to clarify how the content of the wiki
is licensed.

I assume (and hope) that the intent is for the content to be freely
usable in the most flexible way.  But, this has to be explicit.

An issue we ran into with the ePAPR was that on the IEEE
1275 working group site (http://playground.sun.com/1275/home.html)
that there were bindings that we wanted to include in the ePAPR,
but the stuff on 1275 site was not copyrighted and no license
was specified.   This meant that we were in a legally murky
situation if we cut and pasted anything from one of those
document.

My suggestion is to specify that all content of this wiki are
released to the public domain.  How to do this is a bit tricky
but Creative Commons has a license called CC0 that does
this by waving your copyright rights.

Your wiki currently has the following statement above the commit
message:

    Please note that all contributions to FDTWiki may be edited, altered,
    or removed by other contributors. If you do not want your writing to
    be edited mercilessly, then do not submit it here.
    You are also promising us that you wrote this yourself, or copied it
    from a public domain or similar free resource (see
    FDTWiki:Copyrights for details). Do not submit copyrighted work
    without permission!

I would suggest appending the following statement to the above
text:

    You irrevocably agree to release your contribution to the public
    domain.  To the extent possible under law, you waive all copyright or
    neighboring rights to your contribution.  See [CC0|link-to-CC0].

The above language comes from generated text of the CC0 tool from
Creative Commons.

Stuart

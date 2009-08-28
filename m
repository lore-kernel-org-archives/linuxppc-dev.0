Return-Path: <glikely@secretlab.ca>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id A1A45B6F20
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 29 Aug 2009 06:15:51 +1000 (EST)
Received: from mail-qy0-f202.google.com (mail-qy0-f202.google.com
	[209.85.221.202]) by ozlabs.org (Postfix) with ESMTP id F3A80DDD04
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Aug 2009 06:15:50 +1000 (EST)
Received: by qyk40 with SMTP id 40so1505654qyk.9
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Aug 2009 13:15:48 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <955e48b80908281105q60c057e8pfc16213f17da9138@mail.gmail.com>
References: <1250569288.19007.15.camel@pasglop>
	<4A96F69A.5050003@firmworks.com>
	<1251411532.20467.74.camel@pasglop> <4A970C85.8090703@firmworks.com>
	<1251420686.20467.96.camel@pasglop> <4A974295.9020504@firmworks.com>
	<1251427388.20467.122.camel@pasglop>
	<955e48b80908280516m457530cfn3b07b52f2fa2c471@mail.gmail.com>
	<fa686aa40908280906w7953017ek44ee498d57e0a642@mail.gmail.com>
	<955e48b80908281105q60c057e8pfc16213f17da9138@mail.gmail.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 28 Aug 2009 14:09:47 -0600
Message-ID: <fa686aa40908281309g6eedcdb4neb6a96104807a3f1@mail.gmail.com>
Subject: Re: [RFC] Clock binding
To: Stuart Yoder <stuyoder@gmail.com>
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

On Fri, Aug 28, 2009 at 12:05 PM, Stuart Yoder<stuyoder@gmail.com> wrote:
>> Lets *not* do it on power.org. =A0I'd like to see the bindings used by
>> more than just powerpc people, and power.org might become a bit of a
>> mental barrier for non-powerpc folks. =A0kernel.org would be a good
>> host. =A0So would ozlabs or infradead. =A0Or I'd be happy to maintain on=
e
>> on secretlab.
>
> I think broadening it beyond power.org is good. =A0Along those lines I'd =
prefer
> not having this on kernel.org, as device trees are not Linux-centric. =A0=
There
> are other OS vendors I've interacted with that I'd like to see use device=
 trees
> and separating it from Linux may be better IMO.
>
> We could also create a new domain like "devicetree.org" (?)..but it still
> would nee a host.

How about right here:  http://fdt.secretlab.ca/

I've only just created the site.  I'll fill in some documentation and
structure in the next few days.  Feel free to create an account and
start adding stuff.

We'll need to talk about how best to manage bindings and have some
form of review/agreement before a binding is marked as "stable".  And
the site URL could change as well.  But in the meantime we've got a
sandbox to start playing in.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

Return-Path: <glikely@secretlab.ca>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 57B81B7BE3
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 29 Aug 2009 02:06:30 +1000 (EST)
Received: from mail-yw0-f171.google.com (mail-yw0-f171.google.com
	[209.85.211.171]) by ozlabs.org (Postfix) with ESMTP id 9289ADDD04
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Aug 2009 02:06:28 +1000 (EST)
Received: by ywh1 with SMTP id 1so2759850ywh.9
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Aug 2009 09:06:26 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <955e48b80908280516m457530cfn3b07b52f2fa2c471@mail.gmail.com>
References: <1250569288.19007.15.camel@pasglop>
	<1251346157.20467.22.camel@pasglop>
	<4A96F69A.5050003@firmworks.com> <1251411532.20467.74.camel@pasglop>
	<4A970C85.8090703@firmworks.com> <1251420686.20467.96.camel@pasglop>
	<4A974295.9020504@firmworks.com> <1251427388.20467.122.camel@pasglop>
	<955e48b80908280516m457530cfn3b07b52f2fa2c471@mail.gmail.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 28 Aug 2009 10:06:06 -0600
Message-ID: <fa686aa40908280906w7953017ek44ee498d57e0a642@mail.gmail.com>
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

On Fri, Aug 28, 2009 at 6:16 AM, Stuart Yoder<stuyoder@gmail.com> wrote:
> On Thu, Aug 27, 2009 at 9:43 PM, Benjamin
> Herrenschmidt<benh@kernel.crashing.org> wrote:
>> On Thu, 2009-08-27 at 16:36 -1000, Mitch Bradley wrote:
>>> The idea of a wiki as a registration authority is a good one, but I'm
>>> not volunteering to maintain it :-)
>>
>> here goes my hope :-)
>>
>> Do we have wiki's we could use on power.org or should we aim for a
>> community place ? Anybody has suggestions ? I wouldn't even try to
>> maintain a web site myself, that would be irresponsible of anybody to
>> let me do so !
>
> There was an ePAPR wiki on power.org, that I had started developing,
> but it seems to have disappeared. =A0I'm looking into what happened.

Lets *not* do it on power.org.  I'd like to see the bindings used by
more than just powerpc people, and power.org might become a bit of a
mental barrier for non-powerpc folks.  kernel.org would be a good
host.  So would ozlabs or infradead.  Or I'd be happy to maintain one
on secretlab.

What about openfirmware.info?  I don't know anything about Core
Systems who maintains that site though.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

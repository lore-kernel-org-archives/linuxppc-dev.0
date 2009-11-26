Return-Path: <glikely@secretlab.ca>
Received: from mail-yw0-f187.google.com (mail-yw0-f187.google.com
	[209.85.211.187]) by ozlabs.org (Postfix) with ESMTP id 0F52C1007DC
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 26 Nov 2009 16:51:42 +1100 (EST)
Received: by ywh17 with SMTP id 17so439466ywh.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 25 Nov 2009 21:51:41 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1259213345.16367.275.camel@pasglop>
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-2-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-3-git-send-email-albert_herranz@yahoo.es>
	<fa686aa40911221502g2de254d2o4341d9abed0cdf41@mail.gmail.com>
	<1259209283.16367.241.camel@pasglop>
	<fa686aa40911252038y37da8c72y54314a6cc337fc66@mail.gmail.com>
	<1259213345.16367.275.camel@pasglop>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 25 Nov 2009 22:51:21 -0700
Message-ID: <fa686aa40911252151v7b21b44eha5660d06eeda5e5f@mail.gmail.com>
Subject: Re: [RFC PATCH 02/19] powerpc: gamecube: device tree
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Albert Herranz <albert_herranz@yahoo.es>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Nov 25, 2009 at 10:29 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Wed, 2009-11-25 at 21:38 -0700, Grant Likely wrote:
>>
>> But this isn't real OF. =A0Real OF can generate its own valid tree.
>> This is a flat tree, and it is valid according to all users of the
>> flat tree. =A0Besides, the last time we talked about this, you told me
>> that moving it to the root was a good idea, and I happily changed all
>> the 5200 .dts files. =A0:-)
>>
>> http://lists.ozlabs.org/pipermail/linuxppc-dev/2009-January/067046.html
>
> Oh sure. I wasn't sure what the situation vs. real OF was. I just know
> Segher is doing one and it would be nice to have the closest tree :-)
>
> But no big deal, I'm happy with it at the root. I prefer not ommiting it
> completely tho.

agreed.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

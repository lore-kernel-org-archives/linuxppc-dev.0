Return-Path: <glikely@secretlab.ca>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.28])
	by ozlabs.org (Postfix) with ESMTP id 34F76DE19A
	for <linuxppc-dev@ozlabs.org>; Wed, 20 May 2009 13:17:30 +1000 (EST)
Received: by yw-out-2324.google.com with SMTP id 2so115046ywt.39
	for <linuxppc-dev@ozlabs.org>; Tue, 19 May 2009 20:17:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1242788522.16901.134.camel@pasglop>
References: <fa686aa40905190828x251765dek586f5bf8e73e4cf7@mail.gmail.com>
	<20090519162511.7454D17E8058@mail19-dub.bigfish.com>
	<1242788522.16901.134.camel@pasglop>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 19 May 2009 21:17:08 -0600
Message-ID: <fa686aa40905192017r7978fdddq70872dcf86127008@mail.gmail.com>
Subject: Re: Musings on PCI busses
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
	Roderick Colenbrander <thunderbird2k@gmail.com>,
	John Linn <linnj@xilinx.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, May 19, 2009 at 9:02 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Tue, 2009-05-19 at 09:25 -0700, Stephen Neuendorffer wrote:
>
>> I agree that something is called for... =A0The first might be slightly
>> simpler, since it would probably transparently deal with the presence
>> of more than one PLB->PCI bridge?
>
> The current code doesn't already ?

Current code doesn't exist in mainline.  :-)

And, no, the patch Roderick wrote doesn't handle more than one PHB.
No reason it couldn't though.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

Return-Path: <glikely@secretlab.ca>
Received: from mail-yw0-f199.google.com (mail-yw0-f199.google.com
	[209.85.211.199]) by ozlabs.org (Postfix) with ESMTP id EAD05B7C2B
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Nov 2009 03:56:44 +1100 (EST)
Received: by ywh37 with SMTP id 37so5327837ywh.17
	for <linuxppc-dev@ozlabs.org>; Mon, 02 Nov 2009 08:56:42 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <4AEF0D0B.1000100@austin.ibm.com>
References: <4AE8ADCF.6090104@austin.ibm.com>
	<4AE8AF4D.4030403@austin.ibm.com>
	<1256785731.26770.38.camel@pasglop> <4AEF086D.9010600@austin.ibm.com>
	<fa686aa40911020840s3a6a4819g85f3be3a305820bf@mail.gmail.com>
	<4AEF0D0B.1000100@austin.ibm.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 2 Nov 2009 09:56:21 -0700
Message-ID: <fa686aa40911020856u1dba88feib46cb40dce7de6dc@mail.gmail.com>
Subject: Re: [PATCH 1/6 v5] Kernel DLPAR Infrastructure
To: Nathan Fontenot <nfont@austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Nov 2, 2009 at 9:47 AM, Nathan Fontenot <nfont@austin.ibm.com> wrot=
e:
> Grant Likely wrote:
>>
>> On Mon, Nov 2, 2009 at 9:27 AM, Nathan Fontenot <nfont@austin.ibm.com>
>> wrote:
>>>
>>> I saw that Grant Likely is doing updates to all of the of_* stuff right
>>> now,
>>> would it be ok to have these routines here, renamed as dlpar_*, and loo=
k
>>> to merge them in with Grant's updates when he finishes?
>>
>> No because then we're stuck with renaming the API at a later date.
>> Name it what it is, and put it where it belongs. =A0I'll deal with any
>> merge breakage as it occurs.
>>
>
> ok. =A0Would this be better off in powerpc code, or should I go ahead and=
 put
> it
> in something like drivers/of/dynamic.c?

drivers/of/dynamic.c sounds fine to me.  I can always move them if it
find a better place.  Send the patch to me and cc: the
devicetree-discuss@lists.ozlabs.org mailing list.

g.


--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

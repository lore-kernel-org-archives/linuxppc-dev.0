Return-Path: <glikely@secretlab.ca>
Received: from hs-out-0708.google.com (hs-out-0708.google.com [64.233.178.247])
	by ozlabs.org (Postfix) with ESMTP id BD196DE5EB
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Aug 2008 23:31:57 +1000 (EST)
Received: by hs-out-0708.google.com with SMTP id z77so241626hsz.9
	for <linuxppc-dev@ozlabs.org>; Wed, 06 Aug 2008 06:31:55 -0700 (PDT)
Message-ID: <fa686aa40808060631k278e187ej965f0ac08c837937@mail.gmail.com>
Date: Wed, 6 Aug 2008 07:31:55 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Paul Mackerras" <paulus@samba.org>
Subject: Re: [RFC/PATCH 2/3] of: add of_lookup_stdout() utility function
In-Reply-To: <18585.31504.836857.829592@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080806055214.30717.86092.stgit@trillian.secretlab.ca>
	<20080806060239.30717.79273.stgit@trillian.secretlab.ca>
	<20080805.233205.201125898.davem@davemloft.net>
	<18585.31504.836857.829592@cargo.ozlabs.ibm.com>
Cc: devicetree-discuss@ozlabs.org, miltonm@bga.com, linuxppc-dev@ozlabs.org,
	David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Aug 6, 2008 at 4:21 AM, Paul Mackerras <paulus@samba.org> wrote:
> David Miller writes:
>
>> On sparc platforms this is obtained differently.  We obtain the 32-bit
>> instance value of "/chosen/stdout" and convert that into a prom device
>> node path using "instance-to-path".
>
> That's actually exactly what we do too, the linux,stdout-path property
> is just a cache of the result of that process.  The difference is that
> we have to do it early on while we still have OF around, while you can
> do it later.

It's not what we do with flattened device trees blobs though.  In the
flattened tree we're not using a /chosen/stdout property, just the
linux,stdout-path one.

The question that remains is; should there be?  Should the dt blobs
use /chosen/stdout also?  (I'm not familiar enough with real OF to
know the answer.  I'm assuming that an instance value is not the same
as a phandle).

g.

>
> Paul.
>



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

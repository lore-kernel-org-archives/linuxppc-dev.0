Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.241])
	by ozlabs.org (Postfix) with ESMTP id 237CBDE0E9
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Aug 2008 16:35:25 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c34so549366anc.78
	for <linuxppc-dev@ozlabs.org>; Tue, 05 Aug 2008 23:35:24 -0700 (PDT)
Message-ID: <fa686aa40808052335i7a3bbc64g5bcdaca21c3550af@mail.gmail.com>
Date: Wed, 6 Aug 2008 00:35:24 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "David Miller" <davem@davemloft.net>
Subject: Re: [RFC/PATCH 2/3] of: add of_lookup_stdout() utility function
In-Reply-To: <20080805.233205.201125898.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080806055214.30717.86092.stgit@trillian.secretlab.ca>
	<20080806060239.30717.79273.stgit@trillian.secretlab.ca>
	<20080805.233205.201125898.davem@davemloft.net>
Cc: miltonm@bga.com, linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Aug 6, 2008 at 12:32 AM, David Miller <davem@davemloft.net> wrote:
> From: Grant Likely <grant.likely@secretlab.ca>
> Date: Wed, 06 Aug 2008 00:02:44 -0600
>
>> of_lookup_stdout() is useful for figuring out what device to use as output
>> for early boot progress messages.  It returns the node pointed to by the
>> linux,stdout-path property in the chosen node.
>>
>> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
>
> On sparc platforms this is obtained differently.  We obtain the 32-bit
> instance value of "/chosen/stdout" and convert that into a prom device
> node path using "instance-to-path".

How about if I modify it to try both methods?

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.240])
	by ozlabs.org (Postfix) with ESMTP id A77CCDE0C1
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Aug 2008 16:34:06 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c34so549024anc.78
	for <linuxppc-dev@ozlabs.org>; Tue, 05 Aug 2008 23:34:05 -0700 (PDT)
Message-ID: <fa686aa40808052334m2946298aw453afce8b47e6bf7@mail.gmail.com>
Date: Wed, 6 Aug 2008 00:34:04 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: michael@ellerman.id.au
Subject: Re: [RFC/PATCH 2/3] of: add of_lookup_stdout() utility function
In-Reply-To: <1218003249.7893.19.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080806055214.30717.86092.stgit@trillian.secretlab.ca>
	<20080806060239.30717.79273.stgit@trillian.secretlab.ca>
	<1218003249.7893.19.camel@localhost>
Cc: miltonm@bga.com, linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Aug 6, 2008 at 12:14 AM, Michael Ellerman
<michael@ellerman.id.au> wrote:
> On Wed, 2008-08-06 at 00:02 -0600, Grant Likely wrote:
>> From: Grant Likely <grant.likely@secretlab.ca>
>>
>> of_lookup_stdout() is useful for figuring out what device to use as output
>> for early boot progress messages.  It returns the node pointed to by the
>> linux,stdout-path property in the chosen node.
>
> Nice. You don't feel like converting all the places that currently do it
> by hand to use this do you :)

Yep, I'll do this.  :-)

g.

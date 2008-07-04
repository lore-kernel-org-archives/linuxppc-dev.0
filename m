Return-Path: <glikely@secretlab.ca>
Received: from ag-out-0708.google.com (ag-out-0708.google.com [72.14.246.246])
	by ozlabs.org (Postfix) with ESMTP id EEBD2DDE03
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Jul 2008 15:54:28 +1000 (EST)
Received: by ag-out-0708.google.com with SMTP id 8so6520218agc.0
	for <linuxppc-dev@ozlabs.org>; Thu, 03 Jul 2008 22:54:27 -0700 (PDT)
Message-ID: <fa686aa40807032254j76dd1892y7af76c1a2d555809@mail.gmail.com>
Date: Thu, 3 Jul 2008 23:54:26 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: linux-next: manual merge of the powerpc tree
In-Reply-To: <20080703152453.GB2284@secretlab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080703133905.7b6f058f.sfr@canb.auug.org.au>
	<20080703054739.GA643@secretlab.ca>
	<9e4733910807030522h1aa0bl1801ecc5fc877c25@mail.gmail.com>
	<20080703152453.GB2284@secretlab.ca>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linuxppc-dev@ozlabs.org,
	linux-next@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
	Jean Delvare <khali@linux-fr.org>, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jul 3, 2008 at 9:24 AM, Grant Likely <grant.likely@secretlab.ca> wrote:
> On Thu, Jul 03, 2008 at 08:22:18AM -0400, Jon Smirl wrote:
>> Testing was good when the patch was initially posted in January. In
>> the last six months the initial patch set has been sliced and diced
>> into a bunch of different pieces but the contents of this patch are
>> essentially unchanged.
>>
>> I don't care which tree it uses to get to mainline, I'd just like to
>> see it get merged.
>
> Me too, but it is used by some of the mpc8xxx platforms too, so I'd like
> to see an ack from one of those users also.

Okay, I've tested it on my board.  All looks good to me.  I'd prefer
to hear back from one of the Freescale folks, but on a second reading
I think it is pretty safe.  I'll make sure any merge conflicts are
resolved.

Jean, is it okay with you to drop it from your tree and merge it through mine?

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

Return-Path: <glikely@secretlab.ca>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.231])
	by ozlabs.org (Postfix) with ESMTP id 2E0D5DDEC5
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 06:19:57 +1000 (EST)
Received: by wr-out-0506.google.com with SMTP id 71so251813wri
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2007 13:19:56 -0700 (PDT)
Message-ID: <fa686aa40710181319y43aaca59l5b95ca95e99e5ff6@mail.gmail.com>
Date: Thu, 18 Oct 2007 14:19:55 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Grant Likely" <grant.likely@secretlab.ca>, linuxppc-dev@ozlabs.org,
	paulus@samba.org, "Scott Wood" <scottwood@freescale.com>
Subject: Re: [PATCH 2/2] bootwrapper: Bail from script if any command fails
In-Reply-To: <20071017003331.GA28260@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20071016213101.14117.43657.stgit@trillian.cg.shawcable.net>
	<20071016213107.14117.3858.stgit@trillian.cg.shawcable.net>
	<20071017003331.GA28260@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 10/16/07, David Gibson <david@gibson.dropbear.id.au> wrote:
> On Tue, Oct 16, 2007 at 03:31:07PM -0600, Grant Likely wrote:
> > From: Grant Likely <grant.likely@secretlab.ca>
> >
> > Add the 'set -e' command to the wrapper script so that if any command
> > fails then the script will automatically exit
>
> Ah.. this will conflict with my patch to merge dtc (because that
> touches the line invoking dtc to change the path to it).

>From comments I've seen on the list, it looks like if the dtc patch
goes in there still needs to be a couple of review cycles.  Are you
okay with this patch getting merged in the mean time?

Thanks,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195

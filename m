Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.241])
	by ozlabs.org (Postfix) with ESMTP id 9C30FDDE11
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Nov 2007 13:52:46 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id d23so105369and
	for <linuxppc-dev@ozlabs.org>; Fri, 09 Nov 2007 18:52:45 -0800 (PST)
Message-ID: <fa686aa40711091852wa1210d3t3c44d4e43f5ee40d@mail.gmail.com>
Date: Fri, 9 Nov 2007 19:52:45 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Marian Balakowicz" <m8@semihalf.com>
Subject: Re: [PATCH v4 00/13] [POWERPC] Add TQM5200/CM5200/Motion-PRO board
	support
In-Reply-To: <fa686aa40711090920n3e931cbbwf63a66cedd5504de@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20071109171137.16289.39575.stgit@hekate.izotz.org>
	<fa686aa40711090920n3e931cbbwf63a66cedd5504de@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 11/9/07, Grant Likely <grant.likely@secretlab.ca> wrote:
> On 11/9/07, Marian Balakowicz <m8@semihalf.com> wrote:
> > Please review, and if everything is ok schedule for 2.6.24-rc3.
>
> Just to be clear, I won't be picking up these changes until the 2.6.25
> merge window.
>
> The .24 tree is closed for new board support patches and is in bug fix
> only mode.

Ummm; on rereading this (after getting gently nudged on IRC) I realize
my reply was both inaccurate and just plain rude.  Sorry about that,
it was unintentional.

Yes, I'll be picking up your patches into my tree fairly soon (before
the .25 merge window opens), but I cannot ask Paul to pick it up for
2.6.24 because .24 is only open for bug fixes.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195

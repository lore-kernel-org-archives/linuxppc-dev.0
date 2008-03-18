Return-Path: <glikely@secretlab.ca>
Received: from ag-out-0708.google.com (ag-out-0708.google.com [72.14.246.250])
	by ozlabs.org (Postfix) with ESMTP id 3485CDDF38
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Mar 2008 16:10:18 +1100 (EST)
Received: by ag-out-0708.google.com with SMTP id 31so9220365agc.0
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Mar 2008 22:10:17 -0700 (PDT)
Message-ID: <fa686aa40803172210o186e5cb9u113c5c2481c4e730@mail.gmail.com>
Date: Mon, 17 Mar 2008 23:10:01 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Paul Gortmaker" <paul.gortmaker@windriver.com>
Subject: Re: powerpc: cuImage.* creation error
In-Reply-To: <fa686aa40803171622j2183369ei7b384ada72d329d6@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080317193652.GA9550@cs181133002.pp.htv.fi>
	<20080317200754.GA7383@windriver.com>
	<fa686aa40803171541t6357d304i2e7e5292f084d09d@mail.gmail.com>
	<20080317224607.GA10732@windriver.com>
	<fa686aa40803171622j2183369ei7b384ada72d329d6@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, Adrian Bunk <bunk@kernel.org>,
	Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Mar 17, 2008 at 5:22 PM, Grant Likely <grant.likely@secretlab.ca> wrote:
> On Mon, Mar 17, 2008 at 4:46 PM, Paul Gortmaker
>  >     The wrapper script didn't have entries for the TQM8540 board and the
>  >     SBC8548 or SBC8560 boards.  I've assumed that the TQM8540 console is
>  >     8250 based and not CPM based by looking at its defconfig.  There was
>  >     also a trailing * on the TQM8555 entry that I removed too.
>  >
>  >
>  >     Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
>  Acked-by: Grant Likely <grant.likely@secretlab.ca>

Actually, I looked again and tweaked a few details in the patch (it
was duplicating an existing clause in the wrapper script).  I'm just
about to post the edited version which I've tested in my environment.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

Date: Thu, 8 Nov 2001 13:43:32 -0700
From: Val Henson <val@nmt.edu>
To: Ricardo Scop <scop@digitel.com.br>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Linuxppc and MPC8255 routing performance
Message-ID: <20011108134332.D32561@boardwalk>
References: <9729.011107@vanet.com.br> <3BEADFEF.4000307@embeddededge.com> <01110818021400.00999@scop.digitel.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <01110818021400.00999@scop.digitel.com.br>; from scop@digitel.com.br on Thu, Nov 08, 2001 at 06:02:14PM +0300
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Nov 08, 2001 at 06:02:14PM +0300, Ricardo Scop wrote:
>
> >  Using FTP as a benchmark isn't usually the best choice.  You
> > should be running carefully controlled network benchmark applications.
>
> Err.. any suggestions, on those?
>
> Thank you, so far!

Netperf is most common:

http://www.netperf.org/

I prefer netpipe:

http://www.scl.ameslab.gov/netpipe/

Either will do the job.  Write yourself some scripts to do the tests
and also to graph the results automatically.  Just looking at the
numbers as they scroll by won't give you much information on
performance improvement.

-VAL

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

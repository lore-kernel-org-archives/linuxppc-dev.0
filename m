Date: Tue, 2 Nov 1999 10:51:59 +0100 (CET)
From: Michael Schmitz <schmitz@simul.biophys.uni-duesseldorf.de>
To: dsmk@bu.edu
cc: Troy Benjegerdes <hozer@drgw.net>, Paul Mackerras <paulus@linuxcare.com>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: (simple /proc/apm support for pmud) Re: PMU daemon
In-Reply-To: <Pine.LNX.4.20.9911011005150.14599-100000@faust.bu.edu>
Message-ID: <Pine.LNX.4.10.9911021045170.10616-100000@simul.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > Finally, does anyone know how feasable it would be to make pmud have the
> > same API as the intel-ish APMD, since there are a bunch of nice X
> > apps/applets for various window managers that talk to APMD?
> 
> Well, I threw together a quick patch to pmud that does this.  Here is the
> message that I sent to Paul Mackerras the other day.

Just what I need to use the Gnome applet :-) Thanks for implementing this. 
Please take care with the 'pmud sleeps machine at low power'
feature, the write to stderr should be omitted or replaced by a
syslog write there. At least on my machine, writing to stderr kills pmud
in the least 'convenient' moment. 

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

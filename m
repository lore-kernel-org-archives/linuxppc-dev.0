Date: Wed, 15 Sep 1999 17:01:00 -0600 (MDT)
From: Dan Burcaw <dburcaw@terraplex.com>
To: "David N. Welton" <davidw@linuxcare.com>
cc: linuxppc-dev@lists.linuxppc.org, sschoen@linuxcare.com
Subject: Re: New booter
In-Reply-To: <19990915154702.E26759@bassano.linuxcare.com>
Message-ID: <Pine.LNX.4.10.9909151659510.17147-100000@newhope.terraplex.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 15 Sep 1999, David N. Welton wrote:

> 
> Speaking of booting stuff, I have an RS6000 F50 here, which I have got
> running Yellowdog Linux.  To boot it, I currently use a floppy with
> the 2.3.10 kernel.  Does anyone know how to go about booting these
> things from the HD?  Various combinations of "boot scsci/sd@8,0...."
> don't seem to have much effect on it, which seems logical, as the
> kernel is on an ext2 partition.

David: Best bet is to reinstall.. make a ~10meg PReP Boot partition (type
41) and then install Quik 2 from ftp.ppc.kernel.org/pub/linuxppc/misc/

We haven't tried this, but I've been told it works for RS/6000 + Yellow
Dog booting.

> 
> Also, what is the best place to get the most recent devel kernels?
> I'm interested in getting into some of the low level stuff on these
> boxes, and want to start from where everyone else is.  I got 2.3.18 to
> compile, but it doesn't do much after I boot it... seems to get out of
> prom_init and then die somewhere, and I don't know much about getting
> further information out of head.S (prom_init is in C and I can call
> prom_print).
> 
> Anyway, anything people can tell me about this machine, the kernel,
> etc, would be quite useful.
> 
> Thanks for your time,
> -- 
> David N. Welton, Developer, Linuxcare, Inc.
> 415.354.4878 x241 tel, 415.701.7457 fax
> dwelton@linuxcare.com, http://www.linuxcare.com/
> Linuxcare. At the center of Linux.
> 
> 

Dan

Terra Soft Solutions, Inc.
   Yellow Dog Linux
   "The Ultimate Companion for a Dedicated Server"
   http://www.yellowdoglinux.com/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

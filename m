To: linuxppc-embedded@lists.linuxppc.org
Cc: Dan Malek <dan@mvista.com>
Subject: Re: Sandpoint 8240 or 7400
References: <524rylvl3d.fsf@love-boat.topspincom.com> <3A722CA1.3EAE82AF@mvista.com>
From: Roland Dreier <roland@topspincom.com>
Date: 29 Jan 2001 10:07:11 -0800
In-Reply-To: Dan Malek's message of "Fri, 26 Jan 2001 21:04:17 -0500"
Message-ID: <52u26iut9s.fsf@love-boat.topspincom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


    Dan> Got all of those switches set correctly :-)?

Not sure... VxWorks boots fine, does anything need to change for Linux?

    Dan> Let me clean mine up a little (I'm actually doing 405 at the
    Dan> moment) and put it on a server someplace.  No promises, but
    Dan> it should be better than anything else right now.  The
    Dan> Sandpoint seems to always be one of those "background"
    Dan> projects that can't gain momentum.

That would be great.  Let me know when you get a chance to do that.

    >> ......  And (forgive the naive question) how do I build a
    >> kernel image that I can send to the Sandpoint via the serial
    >> port and start from DINK32?

    Dan> What version of DINK do you have?  I'll send you my little
    Dan> downloader as well if you wish.  The easiest way is I just
    Dan> blow the bits over the JTAG with my Abatron....

Actually I figured this out myself a little bit later and managed to
build my own kernel that hung in the same place.

    Dan> It's getting closer, but this Sandpoint stuff still isn't
    Dan> there.

Out of curiousity, what is different about the Sandpoint that requires
changes in the kernel?

Thanks,
Roland

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

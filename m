Date: Sun, 24 Oct 1999 14:34:37 -0400 (EDT)
From: Claude Robitaille <crobitaille@videotron.ca>
Subject: Re: NFS Root - I am further ahead
In-reply-to: <38133E10.BEDBA1CF@netx4.com>
To: Dan Malek <dan@netx4.com>
Cc: Marcus Sundberg <erammsu@kieraypc01.p.y.ki.era.ericsson.se>,
        linuxppc-embedded@lists.linuxppc.org
Message-id: <Pine.LNX.4.10.9910241427510.3857-100000@modemcable220.93-200-24.mtl.mc.videotron.net>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,


> 
> Normally, at this point I find the console device isn't working
> correctly.  That is, the NFS server isn't properly handling things
> in /dev, the symbolic link of /dev/console is wrong, or the
> /dev/console node itself isn't correct.
> 
I am using the dev directory found in mbxroot_min_tgz so I am 
assuming this is ok.

Does any one know if all of a program's dynamic libraries are loaded
upon startup of it or are they just loaded when needed? I think it is
the later so the clue of not seeing all the library read (looking at
tcpdump) does not tell anything.

I try to put a printf at the beginning of init but it does not
show up. I guess this does not say much...

Other idea(s)?

Claude


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

Date: Mon, 29 Jan 2001 15:29:16 +0100 (CET)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Daniel Eisenbud <eisenbud@cs.swarthmore.edu>
cc: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>,
        Amit Chaudhary <amitc@brocade.com>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: mesh SCSI bus locks hard on 7500 when burning a CD-R in dao mode
In-Reply-To: <20010127195924.A19744@allspice.cs.swarthmore.edu>
Message-ID: <Pine.LNX.4.30.0101291528550.2636-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > > So put just that one line redirecting log output to /dev/tty7 into
> > > syslog.conf temporarily and kill -1 syslogd before starting the test.
> >
> > I'll try this variation in a few minutes.
>
> This worked, but I didn't get any useful log output until I started
> getting error 600 from the SCSI midlevel and errors from ext2fs.  I'm
> going to try again, making sure that I have dmesg set as high as

Please report the precise message text.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

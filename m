Date: Tue, 2 Feb 1999 18:23:10 -0800
From: Sean Harding <sharding@gutenberg.uoregon.edu>
Reply-To: Sean Harding <sharding@oregon.uoregon.edu>
To: linuxppc-dev@lists.linuxppc.org
cc: linuxppc-user@lists.linuxppc.org
Subject: CDROM driver bug?
Message-ID: <Pine.SGI.4.02.9902021819270.27517-100000@gutenberg.uoregon.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I'm having some trouble with the CD driver in the current (2.2.1) kernel.
I have an "enhanced CD" which it won't play as an audio CD. xmcd can
access it enough to identify it with CDDB, but clicking 'play' produces
this message in the log:

Feb  2 18:15:29 juliet kernel: sr0: CDROM (ioctl) error, command:
UNKNOWN(0x47) 00 00 00 02 00 45 1d 08 00 
Feb  2 18:15:29 juliet kernel: extra data not valid Current error sr00:00:
sense key Blank Check
Feb  2 18:15:29 juliet kernel: Additional sense indicates Illegal mode for
this track

cdp says:

play(150,312674)
                msf = 0:2:0 69:28:74
                                    CDROMPLAYMSF: I/O error

Since this disc works properly in every other player and OS I've tried, my
best guess is that it is a bug in the CD driver code. I have an Apple 8x
CDROM drive (the 1200i, I believe).

Any ideas on how to fix this?

sean

-- 
Sean Harding sharding@oregon.uoregon.edu|"art may imitate life
http://gladstone.uoregon.edu/~sharding/ | but life imitates t.v."
Consulting: http://www.efn.org/~seanh/  | --ani difranco


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]

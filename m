Message-ID: <389B26DA.DE41F422@socal.rr.com>
Date: Fri, 04 Feb 2000 11:22:02 -0800
From: Richard Young <beethoven@socal.rr.com>
Reply-To: beethoven@socal.rr.com
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Help with ethernet setup on 450 G4.
Content-Type: text/plain; charset=us-ascii; x-mac-type="54455854"; x-mac-creator="4D4F5353"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

    I'm new to this whole Linux thing and I'm trying to find the
quickest way
to the information I need to get my networking working on a Sawtooth G4,
450
with the built in 10/100 base-t.

I did the installation from getting FTP files and not from CD so I may
be missing
something. I am using Ben H's kernel 2.2.15.pre3.  Most everything seems
to be
working (after some painful updates, not knowing which RPM's hold which
files
such as libraries) except for the ethernet stuff.
I don't have much of an idea how the ethernet stuff is handled under
Linux.
I get complaints about eth2 not being a device and the like.  Is there a
conf file
somewhere that specifies something more about the eth2 device?
I tried using linuxconf to set it up but the error log also showed
similar problems
when trying to run those network scripts.
Is the eth2 support compiled into the kernel or is it supposed to be a
module or
something like that? At this point, I'm lost!


Thanks anyone,

Rich Young

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Date: Tue, 27 Nov 2001 13:41:19 +0100 (CET)
From: Gabriel Paubert <paubert@iram.es>
To: <linuxppc-dev@lists.linuxppc.org>
Subject: Why these crazy timstamps on some ChangeSets ?
Message-ID: <Pine.LNX.4.33.0111271323540.15554-100000@gra-lx1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


	Hi,

I just noticed that Changeset 1.678 and 1.679 on linuxppc_2_4_devel and
1.483 on linuxppc_2_4 have a date of February 23rd 2002.

Quite annoying when browsing, because bk revtool displays all changes
since these commits on the same date. I strongly suspect that this will
last for 3 months or so, resulting in several hundred ChangeSets on the
same day. I use latest stable bk version BTW.

I suspect that there is no simple way of fixing this, bk won't like any
fiddling with timestamps to make them more realistic. There may be a
complex way, based on bk undo and reapplying all the patches (changing the
date, user name and host name on the machine so that all patches get more
or less the right values, but it does not look easy).

	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

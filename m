Message-Id: <200003221351.NAA27866@hyperion.valhalla.net>
Date: Wed, 22 Mar 2000 13:51:41 +0000
Subject: Sound Configuration etc.
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: "PPC-DEV" <linuxppc-dev@lists.linuxppc.org>
CC: geert@linux-m68k.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi List,
Before I re-invent (another) wheel...
Are there apps to do the following (on linuxPPC):
1/ determine the range of supported sound formats for built-in sound support
2/ set the format to a chosen one from that set
3/ (OR) play sound files of differing formats.

After looking in the usual places I can't seem to find anything that deals
with any format other than 44100 .wav (even the test prog. from
audio-file-lib seems to set that as the output).  All of the gui-related
apps seem to (usually silently) ignore any attempt at AIFF or sun .au

The problem that I'm having with the 9600 and the dmasound *appears* to be a
discrepancy between the values that the driver thinks are set in the AWACS
and those that have been set up before BootX starts Linux.  Don't you just
love write-only registers :-(

pre-apologies is this is already solved a million times...
Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

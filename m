Message-ID: <3A5EC2BB.945162F2@petig-baender.de>
Date: Fri, 12 Jan 2001 09:39:23 +0100
From: Christof Petig <christof@petig-baender.de>
MIME-Version: 1.0
To: Conrad H Ziesler <cziesler@umich.edu>
CC: Linux PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: iBook's daca mixer, was Re: sources
References: <Pine.SOL.4.10.10101101013560.1041-100000@gorf.gpcc.itd.umich.edu>
Content-Type: multipart/mixed;
 boundary="------------99946EFA773910AD76389D18"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------99946EFA773910AD76389D18
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Conrad H Ziesler wrote:

> here's the code i've been using.  probably you need to add a few bits to
> feature.c in addition to this stuff to enable power to the audio device.
> if you unpack the tar file at the
> base of your linux source tree, you should get an i2c-0.1 directory,
> typing make in there should give you a czi2c.o and dmasound.o modules.
>
> i use aumix to test the mixer.

Hi Conrad,

I did some minimal porting to 2.4.0 (just make it compile) and will
(perhaps this evening?) port your changes to the 2.4 Version of dmasound
(the split up one (dmasound_awacs.c & co)). And I plan to compare the code
with Darwin's.
Yes, I was able to turn off sound by fiddling with the mixer, but no way to
turn it on again ... (I did not yet look at the feature bits)
And changing the pcm2 volume in aumix changed the balance (indicates a bug
somewhere ...)

Here's the minimal patch for 2.4 to make it compile

Christof


--------------99946EFA773910AD76389D18
Content-Type: application/x-gzip;
 name="i2c1-2.4.diff.gz"
Content-Disposition: inline;
 filename="i2c1-2.4.diff.gz"
Content-Transfer-Encoding: base64

H4sICMsiXjoCA2kyYzEtMi40LmRpZmYA7VZtb9s2EP4s/4pDCxSWLdmS4le1HZLOHtYtaYEm
GQYMg6BJVExEplRRqusU+e87krJebMfJh31cEIS69zvyubuENIrALDKgTmBaA3sYPODXIICY
suK7ma79wAzJNxIP9xQ6pmnuG2nXBYPffAYwBefMHc/c0Qwcy7I7/X7/WY/azaqQ1rYNju2e
zVx7rKzPz8GcTEbGDPrqOD/vgMbzjAXptktZlAyYvyYGvFpc/HxhordXBnD6QJKolur6WzSq
yL8O5Kb9N7wHq9JaJyGNtl6QFCwnGYrW9DvJ9thvO6YWJOnWyxOv4CTzMpJ30WkOPd3P7gx4
I3wZgGqa1sxJN8Bc/nJxe3mDefU1GkG36eeYj6a1rgNaAQDGKzK28yWSLzmiEPXzqD4CnxO4
/nz7aeFdffxz+cX7srxYeIvlH1cX17+78pKn47lhT6AvT1tecwd47uc0wCMrghwiGhMvSUmG
zIRxdSlelKQc3nfgB9bJ8WZCL+aE3BtIfrq9vDSw+GGv1M2IH0JveEy0yWhOnpAJs5BmT0jT
JI6VSNE0CfL4aPj12k+bmlgL21OM4oKvmjoZiQnenoFXnmwYyVzt5teP197V58Xt5VJwY1mu
C63a8VVFFi60UkIXGHHHVNH7WhnBhb2A8IjP+JowxBy+RbjfraEf+KbC5YmWbWq1+rYp0G4K
opp3Do7jWpOq/U42b9tFu4PHrmPVHezYsoPV8X8H6zoaaf9Z+x5CY+1LNJ4ERqXThkXFbk50
a+qOR67zkonecNCGxBh9TGpITOeGmDZzYyoBgR2H86bTH/ZeUxbERUjgnYwxDBIW0bvB6ieh
si/E9yxigsJDEQ9WJDwqyekaoYASuVxGY0yhPxlNykw06Gnl9X+gOdhAOXCSu+BDlCHUBJ3G
/payO6k8lJDLdzyBqXJebnyae18Lgs3Vk+NNEQb0ROtXBN+yQBECS7WRt8Kx56GbpmnTsmmo
cpBSvJOK8U/Bt0pRpgayZPtsdiZqxnNUFv14OO3lLXkx5eiFkNSTNDbSj93ABPXXkr/+xg+4
xxL59lhGVLBAbAl3TyKHWhXqW0LDUmF9LxW6BeP0jpEQRPqrBwNaDDS657qqYj635MbCD/ul
K4t/feG+QsV6WSEhH+G4zrHNhKJ6LSFxbCchu15ISJzeRjJYtYqeWDoySxfqfKs9VOewW0JV
xMYGagYpX0rNb8uWiMHunRtz1SZi6KF+wbBJ3oGlI6scYMJOJDxoIBeBg4wavYquEayGN6aL
7jzRA3ULdN+0Xemn9OoIJ9XqwHKxIEd0SrlBkIF3v1n5OU62DLZJgePunoDPBbqyvEhB9BhE
SQZDnH7DkKfGbs+NJCbxwzFs62WYRCk5BUulIKC2jyApOP6fU210FJ9SWkP0QCTB8oSsgVpJ
PwPcMpHnsCtSdaFZa4XURpQmWNuOd3j9F4yfERvXDAAA
--------------99946EFA773910AD76389D18--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

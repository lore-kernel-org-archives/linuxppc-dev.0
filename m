Message-ID: <3AE58FCB.8D4198C3@matrox.com>
Date: Tue, 24 Apr 2001 10:38:05 -0400
From: Alexandre Nikolaev <anikolae@matrox.com>
Reply-To: Alexandre.Nikolaev@matrox.com
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: ppc little-endian port
References: <3AE47B3C.8DF8F330@matrox.com> <3AE5595C.74644FE5@raleigh.ibm.com>
Content-Type: text/plain; charset=koi8-r
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Sorry, we were not clear enough...

Why we did it:
            We have our own image processing PCI board. Hardware guys
decided that since PCI is little endian, it would be better from "their
hardware point of view" to run ppc in little-endian as well. We can do
nothing about that and just have to run ppc in little endian.
Maybe someone else will be on the same boat :)

What else we did:
            We compiled the whole Busy Box using glibc with some
modifications of glibc (endian related + strange bug). Also, we compiled
the ash of standard source (taken from Montavista) using Dietlibc with
no modifications. Then we compiled and run an application under ash
shell (yieldt benchmark from Montavista) and saw good results: typically
7 ms and 11 ms thread context switch time regardless of number of
threads and thread size, for revisions 2.09 and 2.06 respectfully.

Which processors did we test:
            We ran only 7400, revision 2.06 and 2.09.

Alexandre



*****************************************
| Alexandre Nikolaev
| Software Designer
| Matrox Electronic Systems Ltd
| Imaging Department
| Tel. (514) 8226000 ext. 2323
| E-mail: Alexandre_Nikolaev@matrox.com
*****************************************:)


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

Message-ID: <38B271C2.FE9C38C2@cnet.francetelecom.fr>
Date: Tue, 22 Feb 2000 12:23:46 +0100
From: FASSINO Jean-Philippe <jeanphilippe.fassino@cnet.francetelecom.fr>
MIME-Version: 1.0
To: Paul Mackerras <paulus@linuxcare.com>
CC: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>,
        Benjamin Herrenschmidt <bh40@calva.net>,
        Gabriel Paubert <paubert@iram.es>
Subject: Re: Patch for optimize context switch
References: <38B1183A.AC6214E0@cnet.francetelecom.fr> <00022210165901.14669@argo.linuxcare.com.au> <38B25749.2C4B0E1A@cnet.francetelecom.fr>
Content-Type: multipart/mixed;
 boundary="------------DFCC68DA669F2F9B48852857"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------DFCC68DA669F2F9B48852857
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

FASSINO Jean-Philippe wrote:

> Paul Mackerras wrote:
>
> > Interesting.  How much does it reduce the context switch time?  Did you
> > run lmbench or something to see if it makes it go faster?

I have got result of lmbench for Context switching (initlevel 1).
I'm running 5 bench with and without patch on a PBG3/400.
Result is in attach. The average is :

Context switching - times in microseconds - smaller is better
-------------------------------------------------------------
Host                 OS 2p/0K 2p/16K 2p/64K 8p/16K 8p/64K 16p/16K 16p/64K
                        ctxsw  ctxsw  ctxsw ctxsw  ctxsw   ctxsw   ctxsw
--------- ------------- ----- ------ ------ ------ ------ ------- -------

With patch. ======
ppc-linux Linux 2.2.15p  0.6      8     91    26    117      28     239

Without patch ======
ppc-linux Linux 2.2.15p    1      7    102    26    121      28     240


What do you think about this result ???
I'm thinking to say something it is necessary to do many bench run !
Here, performance vary too much between two run to really say something.

Jean-Philippe

--
--------------------------------------------------------------------------
Jean-Philippe FASSINO  Tel :  04 76 76 45 52
CNET : DTL/ASR         mailto:jeanphilippe.fassino@cnet.francetelecom.fr
--------------------------------------------------------------------------



--------------DFCC68DA669F2F9B48852857
Content-Type: text/plain; charset=us-ascii;
 name="res.txt"
Content-Disposition: inline;
 filename="res.txt"
Content-Transfer-Encoding: 7bit

Context switching - times in microseconds - smaller is better
-------------------------------------------------------------
Host                 OS 2p/0K 2p/16K 2p/64K 8p/16K 8p/64K 16p/16K 16p/64K
                        ctxsw  ctxsw  ctxsw ctxsw  ctxsw   ctxsw   ctxsw
--------- ------------- ----- ------ ------ ------ ------ ------- -------
ppc-linux Linux 2.2.15p    1      7     90    26    107      31     222
ppc-linux Linux 2.2.15p    1      7     91    26    110      29     257
ppc-linux Linux 2.2.15p    1      7     90    25    112      26     233
ppc-linux Linux 2.2.15p    1      7     92    25    126      27     243
ppc-linux Linux 2.2.15p    1      7    147    26    150      27     245
ppc-linux Linux 2.2.15p    0      7     92    25    136      28     270
ppc-linux Linux 2.2.15p    1      8     90    27    103      27     211
ppc-linux Linux 2.2.15p    0      9     90    30    112      32     228
ppc-linux Linux 2.2.15p    1      7     91    25    130      29     277
ppc-linux Linux 2.2.15p    1      7     90    25    105      26     211

--------------DFCC68DA669F2F9B48852857--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Message-ID: <38B27416.5F4280D5@cnet.francetelecom.fr>
Date: Tue, 22 Feb 2000 12:33:42 +0100
From: FASSINO Jean-Philippe <jeanphilippe.fassino@cnet.francetelecom.fr>
MIME-Version: 1.0
To: Paul Mackerras <paulus@linuxcare.com>
CC: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>,
        Benjamin Herrenschmidt <bh40@calva.net>,
        Gabriel Paubert <paubert@iram.es>
Subject: Re: Patch for optimize context switch
References: <38B1183A.AC6214E0@cnet.francetelecom.fr> <00022210165901.14669@argo.linuxcare.com.au> <38B25749.2C4B0E1A@cnet.francetelecom.fr> <38B271C2.FE9C38C2@cnet.francetelecom.fr>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


FASSINO Jean-Philippe wrote:

> FASSINO Jean-Philippe wrote:
>
>   ------------------------------------------------------------------------
> Context switching - times in microseconds - smaller is better
> -------------------------------------------------------------
> Host                 OS 2p/0K 2p/16K 2p/64K 8p/16K 8p/64K 16p/16K 16p/64K
>                         ctxsw  ctxsw  ctxsw ctxsw  ctxsw   ctxsw   ctxsw
> --------- ------------- ----- ------ ------ ------ ------ ------- -------
> ppc-linux Linux 2.2.15p    1      7     90    26    107      31     222
> ppc-linux Linux 2.2.15p    1      7     91    26    110      29     257
> ppc-linux Linux 2.2.15p    1      7     90    25    112      26     233
> ppc-linux Linux 2.2.15p    1      7     92    25    126      27     243
> ppc-linux Linux 2.2.15p    1      7    147    26    150      27     245

> ppc-linux Linux 2.2.15p    0      7     92    25    136      28     270
> ppc-linux Linux 2.2.15p    1      8     90    27    103      27     211
> ppc-linux Linux 2.2.15p    0      9     90    30    112      32     228
> ppc-linux Linux 2.2.15p    1      7     91    25    130      29     277
> ppc-linux Linux 2.2.15p    1      7     90    25    105      26     211

Sorry i forgot to say :
    - 5 first run is without patch
    - 5 last run is with path

Jean-Philippe

--
--------------------------------------------------------------------------
Jean-Philippe FASSINO  Tel :  04 76 76 45 52
CNET : DTL/ASR         mailto:jeanphilippe.fassino@cnet.francetelecom.fr
--------------------------------------------------------------------------


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

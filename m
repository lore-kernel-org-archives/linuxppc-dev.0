Message-ID: <38FDC1BA.8F9478D2@sympatico.ca>
Date: Wed, 19 Apr 2000 10:24:59 -0400
From: Stephane Laroche <stephane.laroche@sympatico.ca>
MIME-Version: 1.0
To: Gabriel Paubert <paubert@iram.es>, Jerome.Bertorelle@alcatel.fr
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: char type is unsigned with PPC gcc?
References: <Pine.HPX.4.10.10004191614290.19933-100000@gra-ux1.iram.es>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Ok, message understood.  Thanks for the info.

For the record, ASH 0.2 must then be modified to run properly on the PowerPC:

    Change line 428 of expand.c to "signed char name;"

-Stephane


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

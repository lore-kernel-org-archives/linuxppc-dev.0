Date: Wed, 19 Apr 2000 16:42:24 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Stephane Laroche <stephane.laroche@sympatico.ca>
cc: Jerome.Bertorelle@alcatel.fr, linuxppc-embedded@lists.linuxppc.org
Subject: Re: char type is unsigned with PPC gcc?
In-Reply-To: <38FDC1BA.8F9478D2@sympatico.ca>
Message-ID: <Pine.HPX.4.10.10004191640030.19933-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, 19 Apr 2000, Stephane Laroche wrote:

> Ok, message understood.  Thanks for the info.
>
> For the record, ASH 0.2 must then be modified to run properly on the PowerPC:
>
>     Change line 428 of expand.c to "signed char name;"


I don't have the source offhand, so without any context it's not very
useful. It is actually possible that you are covering a bug with this
change (given the typical case in which the problem shows, it's far from
unlikely).

	Gabriel


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

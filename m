Date: Thu, 18 May 2000 16:06:01 -0400 (EDT)
From: Worth <haworth@ncal.verio.com>
To: Sergio Brandano <sb@dcs.qmw.ac.uk>
cc: "Timothy A. Seufert" <tas@mindspring.com>, luther@dpt-info.u-strasbg.fr,
        Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
        Albrecht Dreﬂ <ad@mpifr-bonn.mpg.de>,
        Tim Wojtulewicz <Tim.Wojtulewicz@nau.edu>,
        linuxppc-dev@lists.linuxppc.org, debian-powerpc@lists.debian.org
Subject: Re: Pismo status 
In-Reply-To: <200005180812.JAA03379@copper.dcs.qmw.ac.uk>
Message-ID: <Pine.SOL.4.10.10005181519400.15607-100000@ncal.verio.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 18 May 2000, Sergio Brandano wrote:

>
>  There is one standard feature of automobiles that has not yet been
>  implemented for computers, namely if you switch off the computer the
>  cooling system should stay on until needed.

Actually it's old hat on mainframes, though that is mainly due to
numerous extremely hot chips with relatively small heat sinks in a
constrained plenum or manifold that depends upon high coolant flow.
And, on liquid cooled systems, to avoiding condensation problems.

>
>  (On my 101, I often hear the fan going on just when I need to shut
>  down. The fact is that when I want to shut down, I do not want to
>  wait for the fan, and I also put the screen down...

No need to wait for the fan, it's not the only cooling source, or
even the primary. The semiconductor junctions are already as hot as they
are going to get and are not producing any more heat. The surface of the
heat sink may have an upward transient at shutdown due to the loss of
airflow, but it's still cooler than those junctions or the bulk of the
heat sink.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

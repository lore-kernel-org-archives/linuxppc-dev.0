Message-ID: <3A70E993.54149F46@mvista.com>
Date: Thu, 25 Jan 2001 19:05:55 -0800
From: Frank Rowand <frank_rowand@mvista.com>
Reply-To: frowand@mvista.com
MIME-Version: 1.0
To: David Edelsohn <dje@watson.ibm.com>
CC: Gabriel Paubert <paubert@iram.es>, Dan Malek <dan@mvista.com>,
        Roman Zippel <zippel@fh-brandenburg.de>, mgreer@mvista.com,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: CONFIG_HIGHMEM on PPC
References: <200101252239.RAA04412@mal-ach.watson.ibm.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


David Edelsohn wrote:
>
> >>>>> Gabriel Paubert writes:
>
> Gabriel> BATS are a good idea, but variable page size are another, superior IMHO,
> Gabriel> possibility. It seems to be what Power4 has from what David said a few
> Gabriel> days ago. I don't know how they mix variable page size with hash tables
> Gabriel> and failed to find any detailed documentation...
>
>         The variable page sizes are determined on a segment by segment
> basis.  The segment type determines how to interpret the page table --
> whether it maps 4KB or 16MB.

The 405 processors have page sizes of
  1k
  4k
 16k
 64k
256k
  1m
  4m
 16m

The 440 processors are the same except
  4m removed
256m added

The page size is determined by a field in the TLB entry.

-Frank
--
Frank Rowand <frank_rowand@mvista.com>
MontaVista Software, Inc

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Message-Id: <200101252239.RAA04412@mal-ach.watson.ibm.com>
To: Gabriel Paubert <paubert@iram.es>
cc: Dan Malek <dan@mvista.com>, Roman Zippel <zippel@fh-brandenburg.de>,
        mgreer@mvista.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: CONFIG_HIGHMEM on PPC 
In-Reply-To: Message from Gabriel Paubert <paubert@iram.es>
   of "Thu, 25 Jan 2001 22:51:16 +0100." <Pine.HPX.4.10.10101252142420.22074-100000@gra-ux1.iram.es>
Date: Thu, 25 Jan 2001 17:39:45 -0500
From: David Edelsohn <dje@watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>>>> Gabriel Paubert writes:

Gabriel> BATS are a good idea, but variable page size are another, superior IMHO,
Gabriel> possibility. It seems to be what Power4 has from what David said a few
Gabriel> days ago. I don't know how they mix variable page size with hash tables
Gabriel> and failed to find any detailed documentation...

	The variable page sizes are determined on a segment by segment
basis.  The segment type determines how to interpret the page table --
whether it maps 4KB or 16MB.

David

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

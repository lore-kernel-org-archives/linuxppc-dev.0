Message-Id: <200101252146.QAA28758@mal-ach.watson.ibm.com>
To: Gabriel Paubert <paubert@iram.es>
cc: Dan Malek <dan@mvista.com>, Roman Zippel <zippel@fh-brandenburg.de>,
        mgreer@mvista.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: CONFIG_HIGHMEM on PPC 
In-Reply-To: Message from Gabriel Paubert <paubert@iram.es>
   of "Thu, 25 Jan 2001 22:40:11 +0100." <Pine.HPX.4.10.10101252211170.22074-100000@gra-ux1.iram.es>
Date: Thu, 25 Jan 2001 16:46:01 -0500
From: David Edelsohn <dje@watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>>>> Gabriel Paubert writes:

Gabriel> The MM design of which Linus is so proud is actually not well suited to
Gabriel> 6xx/7xx processors. Can't speak about high end IBM processors.

	For better or worse, Linux's hardware abstraction layer is the
IA-32 architecture.  And no, that does not map well to other architectures
without an 3-level (?), forward page table.

David

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Message-ID: <3A8189F1.8E6AA8C2@mvista.com>
Date: Wed, 07 Feb 2001 12:46:25 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Roman Zippel <zippel@fh-brandenburg.de>
CC: paulus@linuxcare.com.au, Gabriel Paubert <paubert@iram.es>,
        tom_gall@vnet.ibm.com, linuxppc-commit@hq.fsmlabs.com,
        linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: context overflow
References: <Pine.GSO.4.10.10102071016080.23505-100000@zeus.fh-brandenburg.de>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Roman Zippel wrote:

> Somewhere I lost you, could you explain it a bit more (maybe with an
> example)? What has CONFIG_HIGHMEM to do with the pci mapping???

The only thing they have in common is the desire to consume kernel
virtual space.  They were just two examples of the reason I am trying
to find methods of increasing the kernel virtual space.


	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

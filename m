Date: Wed, 7 Feb 2001 22:16:28 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Roman Zippel <zippel@fh-brandenburg.de>
Cc: Dan Malek <dan@mvista.com>, paulus@linuxcare.com.au,
	tom_gall@vnet.ibm.com, linuxppc-commit@hq.fsmlabs.com,
	linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: context overflow
In-Reply-To: <Pine.GSO.4.10.10102071921140.14928-100000@zeus.fh-brandenburg.de>
Message-ID: <Pine.HPX.4.10.10102072117240.15523-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


	Hi,

> CONFIG_HIGHMEM has little to do with the kernel virtual space. The main
> purpose is to get the memory into user space, where user programs can use
> them. I really don't understand, what problem you're trying to solve. The
> kernel only wants to manage high memory and rarely access it (and uses
> kmap for this), most of the time these pages should be in the user virtual
> address space only.

Confused. If you have up to 64 Gb or RAM (the 7450 has 36 address lines)
and can use not even use one gigabyte for cache, you end up with a
seriously unbalanced system. Depending on what you do of course.

Hey 64 Gb of RAM is not even that expensive today (the only problem is
buffering and additional latency caused by the additional layers
you need to access 100+ modules).

	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: bi_record and initrd 
In-Reply-To: Message from Magnus Damm <damm@opensource.se>
   of "Mon, 18 Nov 2002 09:19:24 BST." <3DD8A28C.E8EABFF@opensource.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 19 Nov 2002 15:29:17 +1100
Message-ID: <10678.1037680157@msa.cmst.csiro.au>
From: Murray Jensen <Murray.Jensen@csiro.au>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, 18 Nov 2002 09:19:24 +0100, Magnus Damm <damm@opensource.se> writes:
>Or maybe there are zillions of applications booting the kernel directly
>without the bootloader..

ppcboot for one ... and it only takes one application, if there are "zillions"
of people using it :-) Cheers!
								Murray...

PS: it doesn't really matter what the mechanism for passing info to the kernel
is, as long as it is an open standard - ppcboot will simply just conform to it.
But this will require effort on someone's part so changes shouldn't be done
lightly or gratuitously - they should be discussed in the list first and the
changes should "add value" (so to speak :-)
--
Murray Jensen, CSIRO Manufacturing & Infra. Tech.      Phone: +61 3 9662 7763
Locked Bag No. 9, Preston, Vic, 3072, Australia.         Fax: +61 3 9662 7853
Internet: Murray.Jensen@csiro.au

Hymod project: http://www.msa.cmst.csiro.au/projects/Hymod/


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

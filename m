Message-ID: <3BFC70DF.4040905@embeddededge.com>
Date: Wed, 21 Nov 2001 22:28:31 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Phillip Lougher <phillip@lougher.demon.co.uk>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: linuxppc_2_4_devel vs MontaVista STB3xxxx kernel
References: <Pine.LNX.4.21.0111220032220.1377-100000@lougher.demon.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Phillip Lougher wrote:


> I am now left wondering whether it may be better to move over to
> the 2_4_devel kernel for the STB3xxxx and for further kernel
> work I need to do for different 4xx chips.

It depends upon what kind of support you want.  If you want to do
everything yourself and hope some of your questions are answered here,
then the _devel kernel is probably OK.  If you want real Linux
technicians dedicated to answer your questions and provide help when
you ask then the MontaVista subscription is for you.  Also, IBM
provides drivers only to STB customers for all of their specialty
peripherals in the chips.  These drivers and other software are only
available with the MontaVista distribution, we don't have access to
this or ability to maintain them in the public sources.

The boards containing STB processors aren't generally available. All of
the software in the public _devel tree is courtesy of MontaVista
employees as their time permits.  You may have to contribute and test
changes to keep the public tree up to date.

Thanks.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

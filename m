Message-Id: <200107181355.IAA22719@ns8.arlut.utexas.edu>
Date: Wed, 18 Jul 2001 08:55:34 -0500
Content-Type: text/plain;
	format=flowed;
	charset=us-ascii
From: Mike DeSimone <desimone@arlut.utexas.edu>
To: linuxppc-dev@lists.linuxppc.org
Mime-Version: 1.0 (Apple Message framework v388)
In-Reply-To: <3B55931C.1D2678D8@highway.ne.jp>
Subject: Re: linux kernel-2.4.7.pre7 from bk tree
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wednesday, July 18, 2001, at 08:46 , kaoru Fukui wrote:
> prep_setup.o(.bss+0x0): multiple definition of `empty_zero_page'
> chrp_setup.o(.bss+0x0): first defined here

Somehow both these .o's are getting linked, and it looks like you need
only one.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Date: Tue, 24 Sep 2002 23:12:40 -0800
From: Ethan Benson <erbenson@alaska.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] remove #ifdef __KERNEL__ from atomic.h
Message-ID: <20020925071240.GA5006@plato.local.lan>
References: <3D914574.7030300@uow.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3D914574.7030300@uow.edu.au>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Sep 25, 2002 at 03:11:16PM +1000, Ben Stanley wrote:
> Hi,
>
> I was trying to compile sumji (formerly xtunes), which requires
> libCommonC++. I found that libCommonC++ would not compile, because it
> needs to use the atomic functions declared in include/asm-ppc/atomic.h .
> However, this file does not declare these functions unless __KERNEL__ is
> defined. I believe that this is incorrect.

no libcommonc++ is broken for using kernel headers.

i think this has been discussed before, specically the atomic stuff.

--
Ethan Benson
http://www.alaska.net/~erbenson/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Subject: Re: Need a Linux PPC kernel which supports the Radeon Mobility 9600
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ken Offer <koffer@arlut.utexas.edu>
Cc: linuxppcdev <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <83C80826-FF21-11D7-B3CC-000393467F1A@arlut.utexas.edu>
References: <83C80826-FF21-11D7-B3CC-000393467F1A@arlut.utexas.edu>
Content-Type: text/plain
Message-Id: <1066231321.646.58.camel@gaston>
Mime-Version: 1.0
Date: Wed, 15 Oct 2003 17:22:01 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 2003-10-15 at 17:09, Ken Offer wrote:
> On Wednesday, October 15, 2003, at 03:19  AM, Benjamin Herrenschmidt
> wrote:

> Hi Ben,
>
> Below are the warnings I get with "make modules_install" and your
> 2.6.0-test7 kernel using the pmac_defconfig config file with pcnet32
> turned off.  This was compiled with gcc 3.2.2.

Something is wrong on your side, either a build system,
incorrect module tools or whatever...

Did you install the module-init-tools ? Those replace modutils for
2.6 (actually, you can have both installed, the correct ones will
be picked up automatically)

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

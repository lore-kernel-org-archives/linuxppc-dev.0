From: kd@flaga.is
Subject: Re: grey area open-source issues..
To: ben bodley <benb@m2tech.co.nz>
Cc: linuxppc-embedded@lists.linuxppc.org
Message-ID: <OF2116073F.F39CAFE6-ON0025694D.0038B177@flaga.is>
Date: Fri, 1 Sep 2000 10:26:15 +0000
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


ben wrote:
>
>
>hello all,
>
>i have a few questions regarding the publishing of linux kernel source
>code.. i know its a little off topic, but i'm sure many developers here
>will have experienced some sort of issues when it comes to a customer
>paying for kernel development, and wanting to keep certain ip in-house..
>
>the thing is, i have ported a lot of code over to linux, that has an
>object only license (ie. we cannot give away the source code, but object
>code is fine).. the linux kernel however is under the GPL license, and
>having modified parts of it, i must make this code available publically
>with the product..
>
>the code i have ported has to be compiled into the kernel..
>
>i can't give it away as i break one license, but break another if i dont
>make it public..
>
>
>
>what is the story here??, and is there exceptions for modules??

Well I believe there is a additional clause to the Linux kernel licence
that
allows developers to link in their propriatary driver to the kernel.
So if you can make your code link in as a driver it should be o.k.
Changes to the kernel it self should be released under the same licence as
the
linux kernel, i.e. the GPL with this additional clause.

This is how e.g. that the sound drivers from
http://www.4front-tech.com/linux.html
can link in their proprietary drivers.

>
>cheers for any insights,
>
>ben

Hope this helps,

K.D.

>
>--
>/\\------------------------------------------------------------------
>ben.bodley/.m2technologyltd.nz/.benb@m2tech.co.nz/.64.9.4448307ext130
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

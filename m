From: rdiz@alumni.deec.uc.pt
Message-ID: <3063.62.48.238.11.1086266990.squirrel@alumni.deec.uc.pt>
In-Reply-To: <1086265044.5978.35.camel@lucy.pep-kaufbeuren.de>
References: <3971.62.48.238.11.1086260430.squirrel@alumni.deec.uc.pt>
    <1086265044.5978.35.camel@lucy.pep-kaufbeuren.de>
Date: Thu, 3 Jun 2004 13:49:50 +0100 (WEST)
Subject: Re: Compiling the kernel using a Bitkeeper tree
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Thanks for the tips and the links, I got it compiling under a minute after
I read your reply, and it also answered some of my doubts.

Helpful indeed :)

Best Regards,
Ricardo Diz


> On Thu, 2004-06-03 at 13:00, rdiz@alumni.deec.uc.pt wrote:
>> Hi,
>>
>> I'm using bitkeeper for the first time, and I find myself unable to
>> compile
>> a kernel from the linuxppc-2.5-benh tree I "cloned".
>>
>> It might be a naive question, but don't get how one can compile it. I
>> don't even find a Makefile in my root rep directory, and I haven't chose
>> the compilations options yet... Using a gziped kernel all I had to do
>> was
>> something like "make ARCH=ppc CROSS_COMPILE=powerpc-linux- menuconfig".
>
> When you clone a tree, it's not checked out. Think of a bk tree like
> a cvs repository interleaved with yor working directory. All you have
> now is the repository, but no checked-out working copy.
>
> I suggest to read http://www.bitkeeper.com/Documentation.FAQS.Linux.html
>
> Some hints:
> - You can configure your bk tree in "checkout-get mode"
> - To see/edit individual files, use "bk get"/"bk edit"
>   It's just like with "cvs co"/"cvs edit", but both is mandantory
> - make and patch know how to check out files automagically
> - run "bk helptool"
> - see linux/Documentation/BK-usage
> - see http://www.bitkeeper.com/cvs2bk.html
>
> --
> Stefan Nickl
> Kontron Modular Computers
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

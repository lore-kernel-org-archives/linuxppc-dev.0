Message-ID: <20010123064948.1745.qmail@kunk.jriver.com>
Subject: Re: [Dri-devel] PPC Lockup (ati-pcigart-branch)
To: linuxppc-dev@lists.linuxppc.org
Date: Tue, 23 Jan 2001 00:49:48 -0600 (CST)
From: Robert E Brose II <bob@kunk.jriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 22 Jan 2001, Dan Malek wrote:

>> > .....  I
>> > wonder why planb works at all....
>>
>> Probably because no one stumbles across the memory it is trashing?
>> Currently, bad_thing_will_happen = vmalloc + virt_to_bus + dma.
>> It could be with the right memory size, modulo addressing, memory
>> controller configuration, timing of the vmalloc, it just may
>> accidently work.  If this is the case, I would be out buying
>> lottery tickets........

On Mon, 22 Jan 2001, Takashi Oe wrote:
> Ok, my apologies, planb doesn't use vmalloc at all these days.  So, there
> is no problem of that kind.  (In the beginning, it had vmalloc with a lot
> of problems as I recall now.)


How about the use of vmalloc in the video frame buffer drivers? At
one point I ran into some weird behavior with controlfb (mmap patched),
XFree4.0, planb and Xawtv (the xawtv display froze the machine). I was
not able to duplicate that in X3.3.6

Bob
--
Robert E. Brose II    N0QBJ
http://www.jriver.com/~bob/
bob@jriver.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

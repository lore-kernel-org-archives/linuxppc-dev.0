Date: Fri, 30 May 2003 17:11:54 -0500
Subject: Re: Kernel Panic in 2.2.x
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v552)
Cc: linuxppc-dev@lists.linuxppc.org
To: linas@austin.ibm.com
From: Hollis Blanchard <hollisb@us.ibm.com>
In-Reply-To: <20030530164822.A28086@forte.austin.ibm.com>
Message-Id: <B8CD0472-92EB-11D7-A2DA-000A95A0560C@us.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Friday, May 30, 2003, at 16:48 US/Central, linas@austin.ibm.com
wrote:
>
> On Fri, May 30, 2003 at 11:40:49AM -0500, Hollis Blanchard wrote:
>> On Friday, May 30, 2003, at 11:34 US/Central, linas@austin.ibm.com
>> wrote:
>>>
>>> Latest & greatest is only the best if you are a developer.  For
>>> users,
>>> old-trustworthy is usually a much better bet.
>>
>> I disagree,
>
> At various points in my life (including the present) I have had to
> sysadmin more than half-a-dozen systems at the same time, and software
> upgrades are one of the worst things a sysadmin has to go through.
> Things like disk crashes and data loss are pretty bad,  but software
> upgrades often result in data loss too, or system outages, or subsystem
> outages.  No sysadmin willingly upgrades a working system.

But you're venting entirely from a sysadmin standpoint. The position
you advocate here nothing new; in fact it's common practice. Even in
the Linux world: have a look at RHAS or Debian "stable" - these things
are constantly on the verge of obsolescence (and that's being kind,
depending on when the last Debian release was ;).

Now think about it from a general user standpoint. "Sleep crashes my
powerbook." "My Xserve doesn't boot." Video drivers, SMP stability and
performance... Even getting away from hardware support, personally I
*require* the input layer, which allows me to plug and unplug USB mice
while also using a PS/2 nipplemouse without freaking out my X server.
It didn't always work like that. Wheelie-mouse support - it wasn't
always there! And now let's step away from the kernel: I'm sure you're
a diehard twm user, but I think we can all agree the KDE and Gnome
projects of today are much better than those from two years ago. And
anyone here who remembers trying to compile x86-developed code with
PowerPC glibc 1.99 will assure you that newer is better. :)

For many (most?) users, newer is better. If that weren't the case, then
what are all these developers *doing* anyways? :) As for sysadmins,
you're free (wise, even :)to keep doing what you've always done: if it
ain't broke don't fix it.

--
Hollis Blanchard
IBM Linux Technology Center


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Date: Tue, 14 Oct 2003 09:37:49 -0500
Subject: Re: Need a Linux PPC kernel which supports the Radeon Mobility 9600
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v552)
From: Ken Offer <koffer@arlut.utexas.edu>
To: linuxppcdev <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <1065823660.601.0.camel@gaston>
Message-Id: <FBD9E413-FE53-11D7-AB64-000393467F1A@arlut.utexas.edu>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Friday, October 10, 2003, at 05:07  PM, Benjamin Herrenschmidt wrote:

> On Fri, 2003-10-10 at 23:56, Ken Offer wrote:
>> Hi all,
>>
>> Any of you know a kernel version or version of the radeonfb driver
>> that
>> supports the "ATI Mobility Radeon 9600" chip in the new 15"
>> Powerbooks?
>>   We've got one in house but the YDL 3.0.1 2.4.22-2a kernel doesn't
>> seem
>> to support it beyond text-mode.  X11 can't start up.
>
> I just fixed that in my 2.6 and I'll backport to 2.4 soon
>
> Ben.

Anyone know how to get to Ben's 2.6 kernel?  Its not that I'm
impatient, its just that the "powers-that-be" above me are. :)

There are instructions at "http://penguinppc.org/~benh" concerning the
2.4 stable, but not the 2.6.  I've tried substituting a "6" for the "4"
in the path, but that didn't work.  And I cloned the "bk clone
bk://ppc.bkbits.net/linuxppc-2.4" tree, but the radeonfb driver was
identical to Ben's 2.4 stable.

+--------------------------------------------------------------+
| Ken Offer                               Office: 512-835-3859 |
| Email: koffer@arlut.utexas.edu             Fax: 512-835-3259 |
| Applied Research Laboratories, University of Texas at Austin |
+--------------------------------------------------------------+


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

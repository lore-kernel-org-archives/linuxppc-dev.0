Message-Id: <200007182137.RAA28182@mal-ach.watson.ibm.com>
To: Nathan Ingersoll <ningerso@d.umn.edu>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Malloc bug? 
In-Reply-To: Message from Nathan Ingersoll <ningerso@d.umn.edu>
   of "Tue, 18 Jul 2000 16:30:27 CDT." <Pine.SO4.4.02.10007181627250.11229-100000@ub.d.umn.edu>
Date: Tue, 18 Jul 2000 17:37:09 -0400
From: David Edelsohn <dje@watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>>>> Nathan Ingersoll writes:

Nathan> On Tue, 18 Jul 2000, Paul Schinder wrote:

>> At 3:40 PM -0500 7/18/00, Nathan Ingersoll wrote:
>> >I've been working on a GTK program for a while now, and I've been
>> >experiencing segfaults within malloc. I was under the impression that
>> >malloc should always return successfully (at least that's what the man
>> >page says).

Nathan> Right, but it's not returning at all. It's segfaulting inside the malloc
Nathan> function before it returns anything.

	Sounds more like something is overwriting one of malloc's internal
data areas or possibly hitting some weird ulimit symptom.

David

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Date: Tue, 18 Jul 2000 19:01:19 -0700 (PDT)
From: Sean Chitwood <darkmane@w-link.net>
Reply-To: darkmane@w-link.net
To: David Edelsohn <dje@watson.ibm.com>
cc: Nathan Ingersoll <ningerso@d.umn.edu>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Malloc bug? 
In-Reply-To: <200007182137.RAA28182@mal-ach.watson.ibm.com>
Message-ID: <Pine.LNX.4.10.10007181859490.16782-100000@darkmane.w-link.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I've seen this before while trying to debug mozilla. Once I loaded the glibc symbols it stopped breaking, so I'd set a breakpt @ main() then load the symbols.

	Sean

On Tue, 18 Jul 2000, David Edelsohn wrote:

>
> >>>>> Nathan Ingersoll writes:
>
> Nathan> On Tue, 18 Jul 2000, Paul Schinder wrote:
>
> >> At 3:40 PM -0500 7/18/00, Nathan Ingersoll wrote:
> >> >I've been working on a GTK program for a while now, and I've been
> >> >experiencing segfaults within malloc. I was under the impression that
> >> >malloc should always return successfully (at least that's what the man
> >> >page says).
>
> Nathan> Right, but it's not returning at all. It's segfaulting inside the malloc
> Nathan> function before it returns anything.
>
> 	Sounds more like something is overwriting one of malloc's internal
> data areas or possibly hitting some weird ulimit symptom.
>
> David
>
>
>

	Sean aka Darkmane
+------------------------------
+ On October 16, 1999 A.D.
+ Sean Chitwood proudly proclaimed
+ his love for Melissa Webb
+ and made her his lifemate
+------------------------------


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

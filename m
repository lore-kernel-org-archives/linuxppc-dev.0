Date: Tue, 6 Jun 2000 09:39:47 -0400
Message-Id: <200006061339.JAA30741@rome.wavemark.com>
From: Kent Borg <kentborg@wavemark.com>
To: jgreen@mvista.com
CC: fray@mvista.com, linuxppc-embedded@lists.linuxppc.org
In-reply-to: <00060516034300.24189@minotaur.mvista.com> (message from Joe
	Green on Mon, 5 Jun 2000 15:21:14 -0700)
Subject: Re: Running from ROM
References: <200006052137.RAA29282@rome.wavemark.com> <393C23CC.3289DD1F@mvista.com> <00060516034300.24189@minotaur.mvista.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Joe Green <jgreen@mvista.com> wrote:
>The project Mark mentioned is specifically for running the kernel
>from ROM.

That doesn't sound horribly complicated.  Groady details to be sure,
but ~conceptually~ easy.

>Are you also asking about running application code from ROM?

Yes.  I realize that it can frequently make sense to compress and load
into RAM, but there is a significant chance that running directly from
ROM could be sensible for us.  Interestingly, part of the reason might
be a "real space" approach, that is, wanting to be deterministic about
whether a given operation can successfully run.  In a system where
sometimes every byte of RAM is needed, I can imagine circumstances
where, depending on the order of operations, some RAM-hungry
operations could sometimes fail and sometimes succeed.  Getting one
more "it's virtual, it does the right thing"-aspect out of the system
could help.  Or maybe not.

So back to the question, it appears there are not scads of people
already doing this.  Suggestions on approaches?  As I let my
imagination run only ugly solution fragments come out on this.


Thanks,

-kb, the Kent who needs to keep reading Rubini's book to learn more
about how the normal case works.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

Message-ID: <3C7F6654.25F7E0FE@lvl7.com>
Date: Fri, 01 Mar 2002 06:30:28 -0500
From: Neil Horman <nhorman@lvl7.com>
MIME-Version: 1.0
To: laurent.pinchart@capflow.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Development tools version
References: <3C7E3471.4080708@capflow.com> <3C7E372A.7B4E5F0@lvl7.com> <3C7F3507.1060702@capflow.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Yes, binutils 2.11.2.  Sorry about my fat fingers... :)
	Say....Speaking of those memory faults.  I never got around to researching
them.  Can you or anyone else provide general notes on exactly what those
patches fix?  I'd certainly appreciate it, as I always wanted to track those
down, but never quite found the time.  Thanks!


Laurent Pinchart wrote:
>
> >
> >
> >I think that the Hard Hat tools will probably be the easiest for you to get up
> >and running with.  They have probably been the most throughly debugged for the
> >8xx.   Although if your looking to put together your own tools for the 860
> >series, we here have built the following, with a reasonably good deal of
> >success.  See the notes for details:
> >
> >Binutils:
> >       2.1.2 - no problems at all.  Download and build them for powerpc-linux and away
> >you go
> >
> >GCC:
> >       2.95.3 - again no real problems.
> >
> >GLIBC:
> >       2.2.4 - relatively easy.  Some issues with memory faults on occasion, which I
> >have not yet traked down.
> >
> >GDB:
> >       5.1.1 - no problems
> >
> >General notes:
> >       I've personally been following the embedded cross-gcc mini howto available on
> >penguinppc.com and I've been more or less happy with the results.  hope that
> >helps!
> >
> Thanks Neil.
>
> I've been able to succesfully use the Hard Hat binaries (actually that's
> so simple that I wouldn't have dared asking questions in this mailing
> list if I hadn't :-), but I'd like to recompile from the sources, in
> order not to depend on a binary release, and also to be able to modify
> the tools if needed.
>
> I tried to compile the tools from the sources without patching them a
> few months ago, and experienced memory faults and a lot of other
> problems with dynamically linked executables (is that a known issue ?).
>
> Recompiling from the SRPMS shouldn't be a hard job, so that's what I'll
> try. All the patches are supposed to be included in there...
>
> Just to make sure, did you mean binutils 2.11.2 ?
>
> Laurent Pinchart

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

Message-ID: <3AB8CC1F.C1F418AA@inn.ericsson.se>
Date: Wed, 21 Mar 2001 16:43:27 +0100
From: Kenneth Johansson <kenneth.johansson@inn.ericsson.se>
MIME-Version: 1.0
To: Mark Powell <medp@primagraphics.co.uk>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Compiling/debugging 405GP and RISCWatch
References: <03ee01c0b206$c4878ea0$3000a8c0@primag>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Mark Powell wrote:
>
>
> Is it possible to use the RISCWatch/JTAG interface as a backend to gdb?

No target exist now that Iam aware of.
The thing that prevent one from beeing written is that the help on the commands that the
riscwatch probe can do is to poor.

for ex. the help for dump is
---
help dump

  dump - upload processor memory in absolute file format

    dump -h <addr>..<addr> - upload hp format (requires transfer protocol)
    dump -b <addr>..<addr> - send data in binary (valid with -h option)
    dump -n <addr>..<addr> - send data in fast binary format
---

This dose not actually work if you trace a dump from the rwppc program you see that
a @<memory_type> is also needed.

On the other hand nobody has tried to make the interface difficult so its probably
quite easy to reverse engineer it.

What you need for gdb is a way to start/stop the cpu and to read/write registers and memory.

Its only the command for writing that is not obvious from the ascii trace that I did.



--
Kenneth Johansson
Ericsson Business Innovation AB   Tel: +46 8 404 71 83
Viderögatan 3                     Fax: +46 8 404 72 72
164 80 Stockholm                  kenneth.johansson@inn.ericsson.se

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

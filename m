From: Ruedi.Hofer@ascom.ch
Date: Thu, 24 Feb 2000 11:01:00 +0100 (CET)
Subject: LinuxPPC2000 on MPC860
To: linuxppc-embedded@lists.linuxppc.org
Message-id: <0FQF00KBBJHKPG@pmdf-it.hasler.ascom.ch>
MIME-version: 1.0
Content-type: MULTIPART/MIXED; BOUNDARY="Boundary_(ID_XxmXUtMXQ9bCQLrdyf3gHw)"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>



--Boundary_(ID_XxmXUtMXQ9bCQLrdyf3gHw)
Content-type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT

Hi

I recently donwloaded the LinuxPPC_2000_lite CD from the LinuxPPC.com page.

Included in this distribution are the libc6 libs, of which I thought, would be nice to have
on my embedded ADS860.
(Having these libs running on my board, I would be able to cross build an application using
shared libs. So far I have libc5 on my PPC target, but cross libc6 on my i386 host)

Unfortunately, right after booting the kernel, it hangs in an infinite loop. I guess that loading
ld.so fails.... (Just a guess, don't know how to debug that.)


Questions:

1. Did someone try LinuxPPC 2000 on MPC860? experience??

2. Should this libc6 work theoretically on MPC860?

3. Does the kernel know something about the dyn. linker ld? Do I have to recompile or
    patch the kernel??

4. Does someone have the cross compiler for the old libc5 ready on the i386 host?

Cheers, Ruedi


--Boundary_(ID_XxmXUtMXQ9bCQLrdyf3gHw)--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

To: Ruedi.Hofer@ascom.ch
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: LinuxPPC2000 on MPC860
References: <0FQF00KBBJHKPG@pmdf-it.hasler.ascom.ch>
From: Marcus Sundberg <erammsu@kieraypc01.p.y.ki.era.ericsson.se>
Date: 25 Feb 2000 13:38:14 +0100
In-Reply-To: Ruedi.Hofer@ascom.ch's message of "Thu, 24 Feb 2000 11:01:00 +0100 (CET)"
Message-ID: <kfysnyhv4nd.fsf@kieraypc07.p.y.ki.era.ericsson.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Ruedi.Hofer@ascom.ch writes:

> Questions:
>
> 1. Did someone try LinuxPPC 2000 on MPC860? experience??
>
> 2. Should this libc6 work theoretically on MPC860?

No, stock glibc does not work on embedded CPUs. Check the list archive.

> 3. Does the kernel know something about the dyn. linker ld? Do I have to recompile or
>     patch the kernel??

Not because of anything related to dynamic linking.

//Marcus
--
Signature under construction, please come back later.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

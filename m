From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Lars Brinkhoff <lars.spam@nocrew.org>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: Sound on G4 tower, success
Date: Sun, 28 Oct 2001 21:39:18 +0100
Message-Id: <20011028203918.4436@smtp.wanadoo.fr>
In-Reply-To: <854roj7fqf.fsf@junk.nocrew.org>
References: <854roj7fqf.fsf@junk.nocrew.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>* kernel compilation without powerbock power management fails.
>  (I resynced serveral times.)
>
>* dmasound_pmac as module can't be loaded because of missing
>  symbols (pmu_register_sleep_notifier, pmu_unregister_sleep_notifier).

Looks like your build is screwed in some way.

Either you have dangling root files or versions files. Try make mrproper
as root to clean the tree (after backing up your .config).

>* dmasound_pmac can be successfully compiled into the kernel, but
>  there is no sound from neither the internal speaker nor from the
>  loudspeakers.  I haven't tried the headphone output.

Did you try playing with a mixer like gmix ? The best way to try if
the sound driver works is the console beep. There are plenty of
reasons why a userland app would fail emitting sound, but the
console beep is entirely kernel driven.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

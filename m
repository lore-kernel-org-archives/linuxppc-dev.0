To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Sound on G4 tower, success
References: <85r8rtcnzj.fsf@junk.nocrew.org>
	<20011026120847.6797@smtp.adsl.oleane.com>
From: Lars Brinkhoff <lars.spam@nocrew.org>
Date: 28 Oct 2001 19:59:36 +0100
In-Reply-To: <20011026120847.6797@smtp.adsl.oleane.com>
Message-ID: <854roj7fqf.fsf@junk.nocrew.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Can you tell me if the version of dmasound in my current rsync helps
> getting sound our of speaker ? It should mute the speaker when the
> jack is plugged and unmute it when unplugged. Can you verify this
> behaviour ?

These are my results:

* kernel compilation without powerbock power management fails.
  (I resynced serveral times.)

* dmasound_pmac as module can't be loaded because of missing
  symbols (pmu_register_sleep_notifier, pmu_unregister_sleep_notifier).

* dmasound_pmac can be successfully compiled into the kernel, but
  there is no sound from neither the internal speaker nor from the
  loudspeakers.  I haven't tried the headphone output.

--
Lars Brinkhoff          http://lars.nocrew.org/     Linux, GCC, PDP-10
Brinkhoff Consulting    http://www.brinkhoff.se/    programming

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

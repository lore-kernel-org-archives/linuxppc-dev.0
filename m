To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Sound on G4 tower, success
References: <85r8rtcnzj.fsf@junk.nocrew.org>
	<20011026120847.6797@smtp.adsl.oleane.com>
From: Lars Brinkhoff <lars.spam@nocrew.org>
Date: 29 Oct 2001 10:03:12 +0100
In-Reply-To: <20011026120847.6797@smtp.adsl.oleane.com>
Message-ID: <85pu766cof.fsf@junk.nocrew.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
> Can you tell me if the version of dmasound in my current rsync
> helps getting sound our of speaker ? It should mute the speaker
> when the jack is plugged and unmute it when unplugged. Can you
> verify this behaviour ?

A freshly rsynced tree works perfectly (apart from the config.in
thing).  Yes, the speaker mutes and unmutes as intended.

--
Lars Brinkhoff          http://lars.nocrew.org/     Linux, GCC, PDP-10
Brinkhoff Consulting    http://www.brinkhoff.se/    programming

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

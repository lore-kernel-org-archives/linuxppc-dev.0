From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Lars Brinkhoff <lars.spam@nocrew.org>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: Sound on G4 tower, success
Date: Fri, 26 Oct 2001 14:08:47 +0200
Message-Id: <20011026120847.6797@smtp.adsl.oleane.com>
In-Reply-To: <85r8rtcnzj.fsf@junk.nocrew.org>
References: <85r8rtcnzj.fsf@junk.nocrew.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
>> Well, I think I know how to control it. It's just that I don't have
>> the HW to test on ;)
>
>I'd be happy to test new sound hacks on a 2001 G4 Tower.

Can you tell me if the version of dmasound in my current rsync
helps getting sound our of speaker ? It should mute the speaker
when the jack is plugged and unmute it when unplugged. Can you
verify this behaviour ?

Ben


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Date: Tue, 23 Oct 2001 20:19:56 -0600 (MDT)
From: Derrik Pates <dpates@dsdk12.net>
To: Dave Ray <g4tinker@yahoo.com>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Sound on G4 tower, success 
In-Reply-To: <20011023233821.76653.qmail@web13101.mail.yahoo.com>
Message-ID: <Pine.LNX.4.33.0110232014430.17119-100000@andromeda.dsdk12.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 23 Oct 2001, Dave Ray wrote:

> Thanks for your insight to these error messages. After
> seeing your confidence that syslog looked okay, I
> hypothesized that the output jacks may be live even
> though the built-in speaker is dead silent. I plugged
> the output audio jacks to an amplifier, and voila,
> sound is is working there just fine.

Yeah. Apparently there's some weird magic crap that you have to do to make
the internal speaker actually work. Far as I know, no one's decoded how to
actually make it work in Linux, and no one seems overly interested in
figuring out how to anyway (since the internal speaker isn't anything
startling sound-quality-wise anyhow).

> regardless of whether a plug is connected. Is this a
> bug? (Don't get me wrong, I'm delighted that it
> works!)

No, as I noted above, it's not a bug, it's just something we don't yet
know how to control, and no one's felt it pressing to figure it out (and
the lack of documentation on it would make it something of a task to
figure out).

Derrik Pates      |   Sysadmin, Douglas School   |    #linuxOS on EFnet
dpates@dsdk12.net |     District (dsdk12.net)    |    #linuxOS on OPN


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

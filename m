From: Steffen Haeuser <SteffenH@hyperion-software.de>
Reply-To: SteffenH@hyperion-software.de
To: Iain Sandoe <iain@sandoe.co.uk>, linuxppc-dev@lists.linuxppc.org
Date: Tue, 25 Jul 2000 21:53:12 -0500
Message-ID: <yam8241.621.146963968@mail.lf-online.de>
In-Reply-To: <200007251926.UAA20564@hyperion.valhalla.net>
Subject: Re: sound again [was: Re: xf4 bug report]
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Am 25-Jul-00 schrieb Iain Sandoe:

Hi!

> Wed, Jul 26, 2000,  Steffen Haeuser wrote:
>> Am 25-Jul-00 schrieb Iain Sandoe:

>> Okay, installed the new one...
>>
>> Well, it behaves just the same like the old kernel... same error-message...

>Glad to hear it boots OK (I wasn't sure that the AppleSCSI driver wouldn't
>panic on boot - it used to on my Lombard)...

Appearently the problem was a wrong entry in /etc/conf.modules... it had

alias sound dmasound

there while correct would be

alias sound dmasound_awacs

After I fixed this the sound modules can be correctly loaded during bootup,
but there is still no sound. Maybe I should go back to the old kernel and try
if it works with that, or don't you think this will make a difference ?

Steffen


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

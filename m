Date: Wed, 18 Jul 2001 18:22:19 -0500
From: "Joseph P. Garcia" <jpgarcia@execpc.com>
To: "Iain Sandoe" <iain@sandoe.co.uk>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: powermac (other ppc?) events
Message-Id: <20010718182219.1d7dfbaa.jpgarcia@execpc.com>
In-Reply-To: <20010718230301.7A05C2F0F9@apollo.valhalla.net>
References: <20010718230301.7A05C2F0F9@apollo.valhalla.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Greetings.

Oops.  forgot to post to the list.

On Thu, 19 Jul 2001 00:01:03 +0100
"Iain Sandoe" <iain@sandoe.co.uk> wrote:
> >> this *should properly* be handled by the dmasound driver - it needs to
> >> understand the sound hardware (and on some models shares interrupts with
> >> other sound stuff)
> >
> > I had this implemented in a patch posted long long ago (mac-like sound
> > controls iirc).  Mostly met with 'I like dual volume controls'.  Given
> > that, it should be runtime disable-able.  so that would mean either another
> > event for our daemon, a proc interface, or an ioctl.  Preference?
>
> well, it's not possible on all models to have the twin volume controls - it
> works on the G3/Beige - which I'm sitting at - and, I think, on some of my
> other machines ... but the headphone level is not independently split out
> (IIRC) on, say, the iMac - (correct me if wrong - I haven't got round to
> looking at it yet)...

Here's where the original post was.  thread easily followable from there.

http://lists.linuxppc.org/listarcs/linuxppc-dev/199909/msg00288.html

I recall my implementation was a little flaky in the sleep department, but the core interupt and register handling is in there.  under AUDIO_SWITCHING defines.  its interwoven into an earlier version of the volume controls that someone else
provided.  And this was written for 2.2.

It's a start, but not at all useful as is.

Hope this helps.

--
Joseph P. Garcia
http://www.execpc.com/~jpgarcia

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Return-Path: <owner-linuxppc-dev@lists.linuxppc.org>
To: m.arturo@libero.it
Cc: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Timidity
References: <3A9CFE58.DDF8B47D@libero.it>
From: Jan Nieuwenhuizen <janneke@gnu.org>
Date: 05 Mar 2001 12:32:30 +0100
In-Reply-To: X-Artu's message of "Wed, 28 Feb 2001 14:34:16 +0100"
Message-ID: <m3bsrga1td.fsf@appel.lilypond.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


X-Artu <m.arturo@libero.it> writes:

> Why Timidity lost notes on my G4/400....help me pls.

I'd like to know too, but I've got no idea how to debug this.
Generating audio in batch may work, though, try:

  timidity -Ou foo.midi
  cat foo.au >/dev/audio

> Track name: ====================
> Track name:  XXXXXXXXXXXXXXXXXX
> Track name:   XXXXXXXXXXXXXXXX
> Track name:
> Track name: XXXXXXXXXXXXXXXXXXX
> Track name: XXXXXXXXXXXXXXXXXXX
> channel 17 => 1
> channel 18 => 2
> channel 19 => 3
> channel 20 => 4
> channel 25 => 9
> Playing time: ~81 seconds
> Notes cut: 444
> Notes lost totally: 1312
>
> sigh :(
>
> Ciao.
>       Marco.
>
>
>
>

--
Jan Nieuwenhuizen <janneke@gnu.org> | GNU LilyPond - The music typesetter
http://www.xs4all.nl/~jantien       | http://www.lilypond.org


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

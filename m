From: benh@kernel.crashing.org
To: <linuxppc-dev@lists.linuxppc.org>,
	Lars Brinkhoff <lars@nocrew.org>
Subject: Re: USB audio
Date: Thu, 21 Feb 2002 17:03:04 +0100
Message-Id: <20020221160304.28138@mailhost.mipsys.com>
In-Reply-To: <85ofii3lk9.fsf@junk.nocrew.org>
References: <85ofii3lk9.fsf@junk.nocrew.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>I got an iSub today.  It's recognized as an USB audio device when it's
>connected, and it basically works, but there are two problems:
>
>* Whenever I kill a process (with ^C, to be precise) writing audio
>  data to the iSub, that process hangs.  From then on, all processes
>  opening the dsp or mixer devices also hang.  If I don't kill the
>  process, suspending and resuming works fine.

I think I know what's wrong, I yet have write a fix though.

>* The "aumix" program (version 2.7) doesn't seem to think there is a
>  volume control.

Don't know about this one.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Date: Fri, 4 Jan 2002 20:52:40 +0100 (CET)
From: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>
To: frowand@mvista.com
Cc: jaf <jaf@lcsaudio.com>,
	Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
	linuxppc-dev@lists.linuxppc.org, jeffk@jdkoftinoff.com
Subject: Re: Having linking problems with atomic_inc(), atomic_dec_and_test()in
  user app, help!
In-Reply-To: <3C360794.E264BDFE@mvista.com>
Message-ID: <Pine.LNX.4.10.10201042051550.24297-100000@zirkon.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > Another corner case seems to be IBM 405 processors that use what I think
> > is a privileged instruction as well in order to work around a hardware
> > bug.
>
> The dcbt instruction (the workaround) should not be privileged.

Thanks; anything not using syncs should be fine then?

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

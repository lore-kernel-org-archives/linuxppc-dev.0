Date: Tue, 6 Apr 2004 00:13:21 +0100
From: Martin Habets <errandir_news@mph.eclipse.co.uk>
To: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: 2.6.5/iBook G3: Oops on resume from sleep
Message-ID: <20040405231321.GA1293@palantir8>
References: <20040405215318.GA2822@mortadelo.pirispons.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040405215318.GA2822@mortadelo.pirispons.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


What sound chip do you actually have? The kernel seems to think
you have a snapper.
You can find out with
cat /proc/asound/cards
after ALSA is loaded.

This capture_source thing was added pretty recently.

Martin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

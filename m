To: Felix Domke <tmbinc@elitedvb.net>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: C++ Library recommendations ...
References: <200301280810.JAA19807@hzsms01.nl.lucent.com>
	<3E365DA5.7060201@elitedvb.net>
From: Roland Dreier <roland@topspin.com>
Date: 28 Jan 2003 07:27:18 -0800
In-Reply-To: <3E365DA5.7060201@elitedvb.net>
Message-ID: <52k7gpthux.fsf@topspin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


    Felix> The thing the STL guy forgot is to keep in mind than
    Felix> 1000*linear (list insertions... ) is still worse than 1*exp
    Felix> (memcpy when doing vector insertions... but take this only
    Felix> as an example) when your list has, for example, 5 entries.

This isn't really on topic for the linuxppc list, but anyway...

What you say isn't really true.  The STL is generally quite efficient,
and provides both vector<> and list<> data structures (in addition to
slist<> and deque<>).

In fact, since a good implementation of vector<> will double the size
of its memory allocation each time it needs to grow it, the cost of
adding elements to the vector<> is still linear when amortized.

Best,
  Roland

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

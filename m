From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Joseph P. Garcia" <jpgarcia@execpc.com>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: 2.4 sleep power consumption patch; final buttons patch
Date: Fri, 17 Aug 2001 22:19:21 +0200
Message-Id: <20010817201921.3923@smtp.wanadoo.fr>
In-Reply-To: <20010816112351.5d9da9f2.jpgarcia@execpc.com>
References: <20010816112351.5d9da9f2.jpgarcia@execpc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>
>> That one should be now done in feature.c, no need to duplicate the code
>> in mediabay.c (in fact, doing it twice may even be a problem).
>
>I just tested without the mediabay patch segment on my system, and the
>fan issue returned.  feature.c doesn't seem to be handling this properly
>at the moment.

The code in feature.c appear to have been broken for the wallstreet
when I split the wallstreet features from desktop heathrow features.

I'll push a fix tonight.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

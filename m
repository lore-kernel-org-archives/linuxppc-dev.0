Date: Thu, 16 Aug 2001 11:23:51 -0500
From: "Joseph P. Garcia" <jpgarcia@execpc.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.4 sleep power consumption patch; final buttons patch
Message-Id: <20010816112351.5d9da9f2.jpgarcia@execpc.com>
In-Reply-To: <20010816094324.6838@smtp.adsl.oleane.com>
References: <20010816040022.28de2b71.jpgarcia@execpc.com>
	<20010816094324.6838@smtp.adsl.oleane.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 16 Aug 2001 11:43:24 +0200
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> >- mediabay IOBUS_enable/disable at sleep (not sure if its related to the fan)
>
> That one should be now done in feature.c, no need to duplicate the code
> in mediabay.c (in fact, doing it twice may even be a problem).

I just tested without the mediabay patch segment on my system, and the fan issue returned.  feature.c doesn't seem to be handling this properly at the moment.


Thanks!

--
Joseph P. Garcia
http://www.lycestra.com/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

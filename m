Date: Mon, 10 Jun 2002 19:42:37 +0000
From: Owen Stampflee <owen@penguinppc.org>
Subject: Re: Why I can't bind the 1023 port?
In-reply-to: <200206111046140.SM00168@------>
To: Daniel Lao <laodx@gzjpg.com>
Cc: linuxppc-dev@lists.linuxppc.org
Message-id: <1023738158.3382.17.camel@whitefusion.lan>
MIME-version: 1.0
Content-type: text/plain
References: <200206111046140.SM00168@------>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 2002-06-11 at 02:18, Daniel Lao wrote:
> The running result was that I could not bind these ports: 1023, 1022, ...
> but it was success in bind 1024 port.
> And while I su to as the super-user, I could bind all these ports!
> I am wondering if the ports were really protected, and how can I use the ports?

Yes, ports < 1024 are reserved ports for "public" applications and only
the superuser can bind them. To use them, you need to be a superuser. I
am not familar with rcp (I would use scp even for local transfers) but
it should be able to run on another port.

Owen

--
Owen Stampflee - owen@penguinppc.org
http://penguinppc.org/~owen


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Date: Tue, 11 Jun 2002 00:02:38 -0800
From: Ethan Benson <erbenson@alaska.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: Why I can't bind the 1023 port?
Message-ID: <20020611000238.E9152@plato.local.lan>
References: <200206111046140.SM00168@------> <1023738158.3382.17.camel@whitefusion.lan>
Mime-Version: 1.0
In-Reply-To: <1023738158.3382.17.camel@whitefusion.lan>; from owen@penguinppc.org on Mon, Jun 10, 2002 at 07:42:37PM +0000
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Jun 10, 2002 at 07:42:37PM +0000, Owen Stampflee wrote:
>
> On Tue, 2002-06-11 at 02:18, Daniel Lao wrote:
> > The running result was that I could not bind these ports: 1023, 1022, ...
> > but it was success in bind 1024 port.
> > And while I su to as the super-user, I could bind all these ports!
> > I am wondering if the ports were really protected, and how can I use the ports?
>
> Yes, ports < 1024 are reserved ports for "public" applications and only
> the superuser can bind them. To use them, you need to be a superuser. I
> am not familar with rcp (I would use scp even for local transfers) but
> it should be able to run on another port.

no it can't, thats why rcp must always be suid root, the entire
no-security model behind rcp/rlogin etc is `if its connecting *from* a
privileged port it can't lie to us about the user its trying to
connect as so we allow the connection'

obviously this is completly flawed model and why you should use ssh/scp
and not rcp/rlogin.

--
Ethan Benson
http://www.alaska.net/~erbenson/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Date: Tue, 10 Jul 2001 19:25:37 +0200
From: Torben Mathiasen <torben@kernel.dk>
To: Armin Kuster <akuster@mvista.com>
Cc: Torben Mathiasen <torben@kernel.dk>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: RTC drift on Walnut?
Message-ID: <20010710192537.A1342@fry>
References: <20010707220903.A1199@fry> <3B4971C3.2ADEAF79@mvista.com> <20010709181719.A798@fry> <3B4B30AF.B925F6A0@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3B4B30AF.B925F6A0@mvista.com>; from akuster@mvista.com on Tue, Jul 10, 2001 at 09:43:27AM -0700
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Jul 10 2001, Armin Kuster wrote:
> I am running on what will be the next version of 405 kernel from
> MontaVista.  It is using the new todc_time routines.  I saw about a 30
> second drift.
>

Thanks for the update. I assume you guys are continously merging your code with
the official PPC tree, so this bug must also be present there.

I think its weird this issue haven't come up on the list before. There seem to
be a lot of people running on the walnut system. It would be interesting to
hear from people _not_ having this drift.

Regards,
Torben Mathiasen

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

From: Benjamin Herrenschmidt <benjamin.herrenschmidt@wanadoo.fr>
To: <linuxppc-commit@fsmlabs.com>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: PVR hell
Date: Tue, 27 Mar 2001 15:25:05 +0200
Message-Id: <20010327132505.23073@mailhost.mipsys.com>
In-Reply-To: <20010327132106.15522@mailhost.mipsys.com>
References: <20010327132106.15522@mailhost.mipsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>I'd like to get this all cleaned up. The best way to acheive that is I
>beleive a bit similar to what Apple does in Darwin: a table with mask/
>value pairs used to "match' the PVR. The table will then give you the CPU
>name, eventually a pointer to some early init code, etc... and a bitmask
>of CPU "features". This bitmask can then be used for things like "has
>L2CR", "has Altivec", "has L3", "has reliable TAU", etc...

Obviously, my intend is to have the table lookup done only once during
kernel boot (head.S), and all further code relying on the table index & CPU
features bit mask retreived at this point to display CPU name, get specific
CPU features, call CPU init code (for cache init, etc...).

I'm pretty sure some bits of head.S would benefit from it too ;)

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sean Mahrt <bigmouth@pionet.net>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: LinuxPPC and interrupt assignment of non-mac cards
 (adaptec3950U2W)
Date: Tue, 1 May 2001 22:36:35 +0200
Message-Id: <20010501203635.21725@smtp.wanadoo.fr>
In-Reply-To: <3AECD67B.FED9D5F8@pionet.net>
References: <3AECD67B.FED9D5F8@pionet.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>> Could be a problem with our code for multifunction devices. Please send
>> me a dump of /proc/device-tree done with lsprop. (I'm sending you lsprop
>> source separately).
>>
>> Ben.
>
>How patient should I be for a response?

Sorry about that, your email got somewhat lost in my archives...

I found it. It looks like your OF creates an intermediate "multifunc-dev"
node between the PCI root and the actual functions.

I'll look at the prom.c code, I beleive it won't handle this case
properly.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Hollis <hollis-lists@austin.rr.com>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: another endianness issue...
Date: Sun, 24 Jun 2001 01:22:50 +0200
Message-Id: <20010623232250.4313@smtp.wanadoo.fr>
In-Reply-To: <01062313332701.00569@silence.internal>
References: <01062313332701.00569@silence.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>
>> Bitfields are not a good way to describe hardware registers.
>
>Why is that? Are there generally bitfield problems other than this one?

Neither structures nor bitfields are good for describing HW registers
because they are always implementation dependant, the actual layout
in memory of a structure of a bitfield depends completely on the
compiler, it's setting, the platform, whatever....

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

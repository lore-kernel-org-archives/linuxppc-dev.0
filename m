From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Adrian Cox <adrian@humboldt.co.uk>
Cc: <ajoshi@unixbox.com>, <linuxppc-dev@lists.linuxppc.org>,
	Daniel Berlin <dan@cgsoftware.com>
Subject: Re: [PATCH]: Make radeonfb work alot better with new powerbooks
Date: Thu, 8 Nov 2001 18:11:52 +0100
Message-Id: <20011108171152.28209@smtp.adsl.oleane.com>
In-Reply-To: <3BEABBDA.6080000@humboldt.co.uk>
References: <3BEABBDA.6080000@humboldt.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>On the other chip I work on (CT69030) I deal with panel issues by
>assuming that the boot firmware set the correct panel width, height and
>type. How safe is this approach on the r128?

Doesn't work. Some radeon firmwares will set a device-tree property
with the panel EDID, but r128's wont afaik, and I think it's bogus
in some cases. I'd prefer we use the i2c.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

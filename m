Message-ID: <3BEABBDA.6080000@humboldt.co.uk>
Date: Thu, 08 Nov 2001 17:07:38 +0000
From: Adrian Cox <adrian@humboldt.co.uk>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Daniel Berlin <dan@cgsoftware.com>,
	linuxppc-dev@lists.linuxppc.org, ajoshi@unixbox.com
Subject: Re: [PATCH]: Make radeonfb work alot better with new powerbooks
References: <EDBD773A-D459-11D5-9D29-0030657B5340@cgsoftware.com> <20011108163848.15922@smtp.adsl.oleane.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt wrote:


> Ok. New coders are always welcome ;) There are a lot of things that would
> be great on both the M3 (r128) and the new radeon: better support for
> external CRT, support for S-video output, better panel detect...


I've been considering an attempt at the panel scaling on the r128, based
on the code in the X driver.

On the other chip I work on (CT69030) I deal with panel issues by
assuming that the boot firmware set the correct panel width, height and
type. How safe is this approach on the r128?

--
Adrian Cox   http://www.humboldt.co.uk/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

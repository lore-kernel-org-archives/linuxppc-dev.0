Date: Thu, 12 Oct 2000 20:08:26 +0300 (EEST)
From: Kostas Gewrgiou <gewrgiou@imbc.gr>
To: "Hendricks, Kevin" <khendricks@ivey.uwo.ca>
cc: Linux/PowerPC Devel List <linuxppc-dev@lists.linuxppc.org>
Subject: Re: dual head r128
In-Reply-To: <200010121619.TAA27476@ns0.imbc.gr>
Message-ID: <Pine.LNX.4.21.0010121951160.1024-100000@idd-01.imbc.gr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 12 Oct 2000, Hendricks, Kevin wrote:

> So that is what is happening.  Perhaps we could simply add a check to
> make sure the REF clock value read from whatever looks like a bios
> actually is one of the 3 allowed values (2950, ...) and if so, assume the
> bios is present and if not default to something else.

It shouldn't be hard to check that the image has bios signature i can
send you info about it if you want, checking that the REF clock has
a sane value won't hurt either though :)

 Kostas


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Date: Sun, 3 Nov 2002 10:55:09 -0800
From: Aldy Hernandez <aldyh@redhat.com>
To: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
Cc: David Edelsohn <dje@watson.ibm.com>,
	linuxppc-dev@lists.linuxppc.org,
	yellowdog-devel@lists.terrasoftsolutions.com
Subject: Re: Status of 2.5.X kernels on PPC Linux, anyone working with NPTL?
Message-ID: <20021103185509.GA2437@redhat.com>
References: <m3r8e2ld89.fsf@frogsleap.quesejoda.com> <66242FA2-EF5C-11D6-81A1-0003938E434C@ivey.uwo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <66242FA2-EF5C-11D6-81A1-0003938E434C@ivey.uwo.ca>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, Nov 03, 2002 at 01:45:18PM -0500, Kevin B. Hendricks wrote:
> Hi,
>
> >I also vaguely recall that Geoff has a list of ABI changes pending.
> >Perhaps we should do all these at the same time.
> >
> Current violations of the abi for ppc linux include:
>
> - missing support for small structure return values in register pairs
> r3, r4

I thought support for this already in place, but gcc had the wrong
endianness in the registers.  If this is so, I already have a patch
for this (not commited though ;-)).

> think about a
> simultaneous push of patches to many of these projects to help them
> maintain
> support for ppc linux.

But but... I've been hacking gcc so long, I can only write in K&R :-).

Aldy

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

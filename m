Message-ID: <3A7DB6B5.7370D32D@vnet.ibm.com>
Date: Sun, 04 Feb 2001 14:08:22 -0600
From: Tom Gall <tom_gall@vnet.ibm.com>
MIME-Version: 1.0
To: Dan Malek <dan@mvista.com>
CC: Troy Benjegerdes <hozer@drgw.net>, linuxppc-dev@lists.linuxppc.org
Subject: Power3/4 Was: Re: Fast Altivec
References: <3A7AE117.628B22A6@mvista.com> <20010202125143.D31120@altus.drgw.net> <3A7D8C19.B829A8D0@mvista.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Dan Malek wrote:

> I also think the POWER3/POWER4 changes are not being done correctly.
> There is too much overlap between the processor and the platform.  The
> POWERx ifdefs should only be related to the processor, not how the
> platform maps stuff to PCI or other things.  Since the 7450 has a 36-bit
> addressing capability, I wanted to use some of the changes along the
> POWERx
> path to help out.  More on that later..........

Hi Dan,

  Point well taken. That does raise the question tho as to how to manage the set
of changes necessary for the Power3 family of machines. At the moment it is nice
that one define handles issues for the entire family of boxes. But you are right
it could be split and I can see the case for making the split.
  Which set of changes are you interested in using for the 7450? You say the chip
has 36 bit addressing, how does that work?

  6392 messages yet to read... ug!  Boy am I behind in mail since LinuxWorld...

--
Hakuna Matata,

Tom

-----------------------------------------------------------
PPC Linux Guy      "My heart is human, my blood is boiling,
                    my brain IBM" -- Mr Roboto, Styxx
tgall@rochcivictheatre.org


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

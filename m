Subject: Re: confused about HID1 bits and G5
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <408FEBB6.105@nortelnetworks.com>
References: <408FEBB6.105@nortelnetworks.com>
Content-Type: text/plain
Message-Id: <1083191370.21436.81.camel@gaston>
Mime-Version: 1.0
Date: Thu, 29 Apr 2004 08:29:31 +1000
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> It appears that we're relying on the firmware to set up a lot of the bits in this register--is there
> any reason we aren't forcing particular values?

Forcing values in HIDs is BAD. The firmware may set/clear bits to work
around specific CPU or north bridge bugs for example. That's why I need
to change the code that force-clear HID4/5 one of these days too and
instead just clear the bits I want to be cleared.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

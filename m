From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Lars Brinkhoff <lars@nocrew.org>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: Bogus interrupt -1
Date: Fri, 20 Apr 2001 19:13:27 +0200
Message-Id: <20010420171327.26883@mailhost.mipsys.com>
In-Reply-To: <85itjzilbx.fsf@junk.nocrew.org>
References: <85itjzilbx.fsf@junk.nocrew.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>At first, the first six or so messages appeared, but everything seemed
>fine.  Later, the last messages appeared, and it seemed like one of
>the two processors in my 2001 Dual G4 had wedged.  According to "top",
>there was always at least 50% idle time.

Did you enable distribution of IRQs to all CPUs ?

I don't think it's completely safe yet.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

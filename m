Mime-Version: 1.0
Message-Id: <p04330100b8504e9e9393@[66.57.250.32]>
In-Reply-To: <20011216233853.23752@smtp.wanadoo.fr>
References: <p04330101b842de27485b@[24.163.44.170]>
 <20011216233853.23752@smtp.wanadoo.fr>
Date: Wed, 26 Dec 2001 23:13:01 -0500
To: <linuxppc-dev@lists.linuxppc.org>
From: Stefan Jeglinski <jeglin@4pi.com>
Subject: Re: ethtool failure with tulip 21143
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>  >>Try defining CACHE_ALIGN to CAL_32LONG, and DESC_ALIGN to u32 dummy[4]
>>>(as in the commented out example).
>>
>>I will look at the de4x5 code again and try this. It's all vaguely
>  >familiar to me... Thanks much!

Yes, it has painfully all come back to me now. I originally switched
to the tulip driver because the de4x5 driver did not function with
the Farallon 10/100 PCI NIC, and I have now reconfirmed this. There
are no error messages when loading the module, but there is some
problem I can't diagnose. The switch lights indicating "it's alive"
never come on, and the network is not ever reachable. With the tulip
driver I can at least get that.

I remember further contacting the de4x5 maintainer about this, and
his response with apologies was that the driver is no longer being
maintained.

I remember even further contacting Donald Becker about somehow
inserting this cache alignment fix into the tulip driver. No
response. So, any thoughts on how to proceed? I have no idea how to
get the fix into tulip to test...


Stefan Jeglinski

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

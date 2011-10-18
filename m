Return-Path: <robert.sciuk@exfo.com>
Received: from smtpinqc.exfo.com (smtpinqc.exfo.com [206.162.164.97])
 by ozlabs.org (Postfix) with ESMTP id F2FD6B71A0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Oct 2011 08:38:46 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Subject: RE: FW: P4080 device tree problems with fsl dpaa ... RESOLVED.
Date: Tue, 18 Oct 2011 17:38:26 -0400
Message-ID: <2DD52030B5146141BEB762A11AE97C4CF6E5E9@SPQCEXC05.exfo.com>
In-reply-to: <CAAXf6LWTU_OVBLfn4Tavo6JxE5UfoN8JuCidB4fbr4-RX+XdAw@mail.gmail.com>
References: <2DD52030B5146141BEB762A11AE97C4CF6E0ED@SPQCEXC05.exfo.com><CAAXf6LXuid9NJcY9DeJYJR0ns6corATzxN2BN5RpkGE08OVcQw@mail.gmail.com><2DD52030B5146141BEB762A11AE97C4CF6E2E7@SPQCEXC05.exfo.com>
 <CAAXf6LWTU_OVBLfn4Tavo6JxE5UfoN8JuCidB4fbr4-RX+XdAw@mail.gmail.com>
From: "Robert Sciuk" <robert.sciuk@exfo.com>
To: "Thomas De Schampheleire" <patrickdepinguin+linuxppc@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



[snip]

>=20
> How and what type of packets are you sending? Raw MAC frames, IP? Are
> you using custom code, or can you try things like ping?
> If you are using IP, I trust you checked the Linux configuration (like
> assigning a valid IP address to the interface and making sure the
> routing table is correct).
>=20
> Best regards,
> Thomas

Thomas,

I would like to thank you for your very kind assistance on the DPAA =
problem.  We traced the problem to the connection between MAC and PHY, =
and we have resolved it by instrumenting code and comparing the TBI and =
PHY initialization from u-boot to the Linux DPA code, and replacing some =
of the "magic numbers" we found in the driver with "magic numbers" we =
know to work.  OUCH!

We spent an inordinate amount of effort in trying to understand the =
undocumented code/tree, but I am convinced that the device-tree approach =
to embedded boards is a very valuable approach, and will ultimately =
solve many more problems than it creates short term. =20

Again, your information was of great assistance, and I look forward to =
being able to pay forward the same kind of assistance in the future.

Cheers,
Rob Sciuk.

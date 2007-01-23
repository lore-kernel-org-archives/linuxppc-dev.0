Return-Path: <tmorrison@empirix.com>
Received: from empbedex1.empirix.com (empbedex1.empirix.com [12.38.203.54])
	by ozlabs.org (Postfix) with ESMTP id 973F8DDEEC
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 24 Jan 2007 05:03:04 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: JTAG emulator for MPC8548E (v2)
Date: Tue, 23 Jan 2007 13:02:54 -0500
Message-ID: <BD261180E6D35F4D9D32F3E44FD3D901062D1F17@EMPBEDEX.empirix.com>
In-Reply-To: <528646bc0701230956v26e34c5bx7d3fc082fe1d20c9@mail.gmail.com>
References: <BD261180E6D35F4D9D32F3E44FD3D901062D1E42@EMPBEDEX.empirix.com>
	<528646bc0701230956v26e34c5bx7d3fc082fe1d20c9@mail.gmail.com>
From: "Morrison, Tom" <tmorrison@empirix.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

We actually have one of these - and the H/W engineer is NOT
happy at all. Apparently, it is NOT that stable for single
step operations, and does NOT give a consistent view of the=20
All the internal registers and/or the ability to view all
the registers natively!

I am hoping for one that is more consistent and aware (and stable).

-----Original Message-----
From: glikely@gmail.com [mailto:glikely@gmail.com] On Behalf Of Grant
Likely
Sent: Tuesday, January 23, 2007 12:56 PM
Subject: Re: JTAG emulator for MPC8548E (v2)

On 1/23/07, Morrison, Tom <tmorrison@empirix.com> wrote:
>
> What do people recommend for a JTAG emulator for the MPC8548E
> (version 2 silicon).

Check out the BDI-2000 from Abatron

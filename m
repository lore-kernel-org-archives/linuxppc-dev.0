From: clark@esteem.com
Message-Id: <1.5.4.32.20000911170434.006a51e8@pop.esteem.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Mon, 11 Sep 2000 10:04:34 -0700
To: "Navin Boppuri" <nboppuri@trinetcommunication.com>
Subject: Re: Differences between MPC823 powerpc & any other powerpc
Cc: linuxppc-embedded@lists.linuxppc.org
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


At 11:48 AM 5/12/00 +0100, you wrote:
>
>Hello,
>
>I would like to know what are the basic difference between the MPC823
>PowerPC and any other PowerPC , say, the G4? Why dont the binaries running
>on G4 not work correctly on the MPC823?
>
>Thank you,
>Navin.
>
>
>

        For starters the MPC823 has no FPU. I think you could compile FPU
emulation into the kernel to remedy this but I'm not sure. G4 compiled
programs may use alti-vec instructions but I'm not sure on this either.

        Good luck,

        Conn Clark


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

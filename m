Return-Path: <Valdis.Kletnieks@vt.edu>
Received: from lennier.cc.vt.edu (lennier.cc.vt.edu [198.82.162.213])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3BE7514008D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Mar 2014 10:59:55 +1100 (EST)
To: Ashish <curieux.khetan@gmail.com>
Subject: Re: MPC8641 based custom board Kernel stuck at 1000Mhz core clock
In-Reply-To: Your message of "Thu, 27 Mar 2014 16:04:37 +0530."
 <5333FEBD.3050704@gmail.com>
From: Valdis.Kletnieks@vt.edu
References: <CAERE9PrGaOJS3YTBv61=JCEGyPxGnqr_8j=eKrnn7Y9vi8dMug@mail.gmail.com>
 <52BBF1CB.3070006@gmail.com>
 <CAERE9Prr_C31D96zuYbV0KQ7b_j8Te0A2DO8C+6YtetF0e6M_w@mail.gmail.com>
 <CALyraeMiKQsoHV8AQ5SOz926z_YBD3LbFFNefMpRibYOt=Vo=Q@mail.gmail.com>
 <CAERE9PrX61oNtQoT1tpL_+rXfirFeMa4woD2P2TSUJ_Xj-h4rg@mail.gmail.com>
 <5333FEBD.3050704@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1395937889_1568P";
 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Thu, 27 Mar 2014 12:31:29 -0400
Message-ID: <3723.1395937889@turing-police.cc.vt.edu>
Cc: scottwood@freescale.com, linuxppc-dev@lists.ozlabs.org,
 kernelnewbies <kernelnewbies@kernelnewbies.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--==_Exmh_1395937889_1568P
Content-Type: text/plain; charset=us-ascii

On Thu, 27 Mar 2014 16:04:37 +0530, Ashish said:
> Hi,
>
>   I am using MPC8641-HPCN based custom board and able to boot linux at
> MPX clock 400Mhz and core clock 800mhz. When I am increasing core
> frequency ie MPX clock at 400Mhz and core at 1Ghz, kernel stuck.

Step 0:  Prove to us that your core actually runs reliable and stably at 1Ghz.

Step 1: Figure out *where* it gets stuck.  If you have earlyprintk working on
your board, adding 'initcall_debug ignore_loglevel' to the kernel cmdline often
helps track down where a kernel hangs during boot.


--==_Exmh_1395937889_1568P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Exmh version 2.5 07/13/2001

iQIVAwUBUzRSYQdmEQWDXROgAQIT2w/+NpC7OzBGU5xoUZslBRigBRTd5vFKHmQ4
Sy4lXM3ZtjvV6RzmjfdydkMuY4BKQtu50CqHU+XaaJxbZ9blUq3LYbvjBppwFsRY
CIFIWPZ4wAoWK/ErrdcZTEnt71GdxZHeR1MEPRz6wVagQCw6abemVYjO3FIzn55/
QnVARfOBI8jZhPaHgMlQ185ft2cFBWCOOczQSEhvpc0FZMDh6Plle4oSYbPv+KCM
wr7ISqX7KNARN304qccqvpOaG+f4bgET5AtCdxUfQMcrucmzTd34g99xeap2JDyH
YNbBssXtW1khYs8yslhdNLxfn8zkR0xhQYaqyyUP6JgmXplpMDmzdssjSNIrg5n1
DfS3H9U3qIOR2RLGXIR+1NnOmbkOOGeNc3Rlx2tCqXRLv+NgtQD02T7yUiASLNQE
4N1aTRWvHnq2dcUIQLk2o9poQbuPUrrYMlF+Sq8kUUSEIWyU8kny/hHC01mCGxnE
WWSIfeP7yNrnNggzIiFoRpGVqxtcN8v+y5/k84N4r7ApXMtypWO/FY52CDtLxd41
Qr5V2NQdJX3Ka9HUEDbxTgU962VNrdByZzUi1xhKi7ad1bn+Zj9BMS9BsArAvdYi
iVdhE36G8am/2nmmO2UiYql+sOaLMF/2jXUO4It6KEfq2Sin9S5D43q40UaHLH+U
P4Bz/LfR9sQ=
=1DC8
-----END PGP SIGNATURE-----

--==_Exmh_1395937889_1568P--

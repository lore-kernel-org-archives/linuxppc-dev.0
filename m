Message-ID: <39CC2C86.40AF66CF@ncal.verio.com>
Date: Fri, 22 Sep 2000 21:07:34 -0700
From: Henry Worth <haworth@ncal.verio.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: Linux keycodes and left cursor on Pismo
References: <Pine.SOL.4.10.10009221556010.17778-100000@ncal.verio.com> <39CBD3D0.C7F1964A@wanadoo.fr>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Martin Costabel wrote:
>
> F13 (keycode 0x69) works for me as MagicSysRq (ADB keyboard, kernels
> 2.2.x or 2.4.0-x).
>

Ah, well no F13 or equiv. combo on a Pismo. Grepping through
the sources it doesn't appear there is any bootparm or /proc
entry to change it... So changing it to 0x6f in
/arc/ppc/kernel/pmac_setup.c and rebuilding it should
give you F12 instead.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

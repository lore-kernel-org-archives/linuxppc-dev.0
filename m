From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15957.24358.452126.114298@argo.ozlabs.ibm.com>
Date: Fri, 21 Feb 2003 10:05:10 +1100
To: "Wells, Charles" <Charles.Wells@nielsenmedia.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: FW: PowerMac vs. Intel for PowerPC Development Host
In-Reply-To: <DF2B720CF774D21189EE00805FA7FA22051783B9@nmrusdunsx3.nielsenmedia.com>
References: <DF2B720CF774D21189EE00805FA7FA22051783B9@nmrusdunsx3.nielsenmedia.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Wells, Charles writes:

> While I don't want to get into the Mac vs. Intel debate, I have an
> observations about Paul's numbers.
>
> Building kernels requires a lot of disk accesses.  The Toshiba/Hitachi/IBM
> style hard disks that are used in most modern laptops (Mac or Intel) are
> notoriously slow compared to full-sized desktop hard drives (particularly
> the high performance SCSI drives).  It wouldn't be meaningful to compare two
> systems without describing the access time performance of the hard disks.

OK, the hard disk on the G4 is an 80GB Seagate ST380021A, while the
hard disk on the P4 (which is not a laptop) is a 40GB Seagate
ST340016A, so they should be pretty similar.  On a `hdparm -tT' test,
the G4 gets 39.75 MB/s from disk whereas the P4 gets 31.98 MB/s.  In
any case, after the first compilation, it hardly hits the disk at all
on either machine.

Paul.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

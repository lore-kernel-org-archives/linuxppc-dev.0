Date: Thu, 20 Feb 2003 15:15:02 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Paul Mackerras <paulus@samba.org>
Cc: "Wells, Charles" <Charles.Wells@nielsenmedia.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: FW: PowerMac vs. Intel for PowerPC Development Host
Message-ID: <20030220231502.GA29127@f00f.org>
References: <DF2B720CF774D21189EE00805FA7FA22051783B9@nmrusdunsx3.nielsenmedia.com> <15957.24358.452126.114298@argo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <15957.24358.452126.114298@argo.ozlabs.ibm.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Feb 21, 2003 at 10:05:10AM +1100, Paul Mackerras wrote:

> OK, the hard disk on the G4 is an 80GB Seagate ST380021A, while the
> hard disk on the P4 (which is not a laptop) is a 40GB Seagate
> ST340016A, so they should be pretty similar.  On a `hdparm -tT'
> test, the G4 gets 39.75 MB/s from disk whereas the P4 gets 31.98
> MB/s.  In any case, after the first compilation, it hardly hits the
> disk at all on either machine.

I can't see any reasonable machine hitting the disk hard, pretty much
any files required during compilation should buffer/page cache.  When
I compile here, the disk is almost completely inactive except for the
odd shirt burst of dirty pages being flushed every 5s or so.


  --cw

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

Date: Thu, 25 Mar 2004 10:18:22 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: Markus Bernauer <markus.bernauer@freenet.de>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Further questions on performance of IBM440GX/GP regarding boot time
Message-ID: <20040325181822.GB13701@gate.ebshome.net>
References: <4062C61E.1040004@freenet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4062C61E.1040004@freenet.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Mar 25, 2004 at 12:44:30PM +0100, Markus Bernauer wrote:
> I was following the discussion about the performance of  different
> IBM440GX/GP systems with increasing interest.
> We are going to use an IBM400GP in conjunction with the Ebony-Evalboard
> for a project that demands boot times as short as possible. Could you
> please give me any hints about how fast your systems boot and whether
> you optimized the systems to reach these bootup times.

Well, I cannot say I spent any time optimizing boot times :).

My estimation is 1-2s for bootloader, 2-3s for Linux kernel, provided you kernel
is in the flash memory, and doesn't have a lot of hw to detect (like SCSI
disks). Also note that time I gave to the kernel doesn't include startup
scripts (everything started by init). Usually init processing takes a lot of
time, so using something like busybox helps a lot.

One thing, to achieve such boot speeds _disable_ serial system console.

My estimations are based on 405GPr-based hw boot times.

> I know that there are several possibilites to reduce boot time of linux,
> but at the moment it would suffice to have some values for orientation.
> I also know that there are differences in boot time dependent on
> hardware and software configuration so it would be nice to get
> at least little information about the systems the different boot times
> belong to.
> The other, less preferable possibility to achieve fast bootup, would be
> to use SCIOPTA. But I am afraid this would be off topic, isn?t it?;-)

Hmm, I have no idea what SCIOPTA is :).

Eugene

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

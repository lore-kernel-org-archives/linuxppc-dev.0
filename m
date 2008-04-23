Return-Path: <jacmet@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.190])
	by ozlabs.org (Postfix) with ESMTP id 3D170DE4D3
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Apr 2008 04:27:51 +1000 (EST)
Received: by nf-out-0910.google.com with SMTP id g16so1533232nfd.9
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 23 Apr 2008 11:27:49 -0700 (PDT)
To: "Sam Karp" <sam.d.karp@gmail.com>
Subject: Re: Fwd: SecretLab 2.6.24 with USB
References: <800687fe0804141927y1f6ea75cv7ad0ba68b4fa637a@mail.gmail.com>
	<fa686aa40804211109g2f7f45d0gf836be46e2c1a40b@mail.gmail.com>
	<16825460.post@talk.nabble.com>
	<fa686aa40804221309g7d0749e8qc329ad72389f0138@mail.gmail.com>
	<480E4EBD.3010202@zin-tech.com>
	<fa686aa40804221355s11f8fd6em3f2075bbb2073c8@mail.gmail.com>
	<480F4E8E.4010506@zin-tech.com> <87iqy8haf8.fsf@macbook.be.48ers.dk>
	<Pine.LNX.4.62.0804231741110.20567@henka.dyndns.org>
	<800687fe0804231007l5fdf664fn1d94a1e40dd7fe74@mail.gmail.com>
	<800687fe0804231047k46d1310as9f37de3a5bbbf259@mail.gmail.com>
From: Peter Korsgaard <jacmet@sunsite.dk>
Date: Wed, 23 Apr 2008 20:27:44 +0200
In-Reply-To: <800687fe0804231047k46d1310as9f37de3a5bbbf259@mail.gmail.com>
	(Sam Karp's message of "Wed\, 23 Apr 2008 12\:47\:00 -0500")
Message-ID: <87k5iofmu7.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: Peter Korsgaard <jacmet@gmail.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

>>>>> "Sam" == Sam Karp <sam.d.karp@gmail.com> writes:

Hi,

 Sam> [   77.688344] sd 0:0:0:0: [sda] 15584 512-byte hardware sectors (8 MB)
 Sam> [   77.770266] sd 0:0:0:0: [sda] Write Protect is off
 Sam> [   77.827242] sd 0:0:0:0: [sda] Assuming drive cache: write through
 Sam> [   77.919287] sd 0:0:0:0: [sda] 15584 512-byte hardware sectors (8 MB)
 Sam> [   78.001280] sd 0:0:0:0: [sda] Write Protect is off
 Sam> [   78.058131] sd 0:0:0:0: [sda] Assuming drive cache: write through
 Sam> [   78.131034]  sda:<7>usb-storage: queuecommand called
 Sam> [   78.201342]  sda1
 Sam> [   78.230344] sd 0:0:0:0: [sda] Attached SCSI removable disk
 Sam> [   78.298014] sd 0:0:0:0: Attached scsi generic sg0 type 0

Looks good.

 Sam> ls /dev/sd*
 Sam> ls: /dev/sd*: No such file or directory

Do you use mdev/udev? If not, you'll have to create the device nodes
yourself.

-- 
Bye, Peter Korsgaard

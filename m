Return-Path: <jacmet@gmail.com>
Received: from mu-out-0910.google.com (mu-out-0910.google.com [209.85.134.190])
	by ozlabs.org (Postfix) with ESMTP id AA408DDFBB
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 23 Apr 2008 16:43:15 +1000 (EST)
Received: by mu-out-0910.google.com with SMTP id w8so2780260mue.9
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 22 Apr 2008 23:43:12 -0700 (PDT)
To: aaronsells <aaron.sells@zin-tech.com>
Subject: Re: SecretLab 2.6.24 with USB
References: <800687fe0804141927y1f6ea75cv7ad0ba68b4fa637a@mail.gmail.com>
	<fa686aa40804211109g2f7f45d0gf836be46e2c1a40b@mail.gmail.com>
	<16825460.post@talk.nabble.com>
From: Peter Korsgaard <jacmet@sunsite.dk>
Date: Wed, 23 Apr 2008 08:43:06 +0200
In-Reply-To: <16825460.post@talk.nabble.com> (aaronsells's message of "Tue\,
	22 Apr 2008 12\:23\:57 -0700 \(PDT\)")
Message-ID: <87k5ipkr5x.fsf@macbook.be.48ers.dk>
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

>>>>> "aaronsells" == aaronsells  <aaron.sells@zin-tech.com> writes:

Hi,

 aaronsells> I've tried this on my ML403 board with no success.  My
 aaronsells> Xilinx git tree is current.  I'm using Peter's most
 aaronsells> recent patches from
 aaronsells> http://peter.korsgaard.com/patches/linux/. I'm using an
 aaronsells> OpenEmbedded console-image mounted via nfs as my root
 aaronsells> filesystem.  I don't receive any messages when I plug USB
 aaronsells> devices into the board (keyboard, mouse, webcam).  Any
 aaronsells> ideas on how I can troubleshoot this?

Did you register a struct platform_device for the c67x00?

-- 
Bye, Peter Korsgaard

Return-Path: <kkboyanov@gmail.com>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.236])
	by ozlabs.org (Postfix) with ESMTP id 0109CDDECD
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 23 Aug 2007 17:47:47 +1000 (EST)
Received: by wr-out-0506.google.com with SMTP id 71so339103wri
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 23 Aug 2007 00:47:45 -0700 (PDT)
Message-ID: <929bf310708230047n70bfe883gb963eba6e254b479@mail.gmail.com>
Date: Thu, 23 Aug 2007 09:47:45 +0200
From: "Konstantin Boyanov" <kkboyanov@gmail.com>
To: "Johan Borkhuis" <j.borkhuis@dutchspace.nl>
Subject: Re: Driver for device behind a PCI-VME bridge
In-Reply-To: <46CAE973.6040306@dutchspace.nl>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_151991_16638288.1187855265285"
References: <929bf310708200140w6efc57f6k81a1339845059e2d@mail.gmail.com>
	<46C954AA.7050609@dutchspace.nl>
	<929bf310708200158m3dab7669j56e4dbf2d84f17a@mail.gmail.com>
	<929bf310708210055k3970c3chfc097ff776af439a@mail.gmail.com>
	<929bf310708210056s2b699500x36c6b1ae83881496@mail.gmail.com>
	<46CAA332.9060907@dutchspace.nl>
	<929bf310708210249x3cf8342aq4523d2a895d78eb@mail.gmail.com>
	<46CAE973.6040306@dutchspace.nl>
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

------=_Part_151991_16638288.1187855265285
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi again,

First of all thanks for reply.


> I attached a diff to the 3.7 version of the Motorola patch. I hope this
> will help you. This is not the Xenomai version, but the standard version
> with VME interrupts per level. The mechanism for Xenomai is identical,
> but I don't know yet about the legal status of this. The attached patch
> has also been provided to Motorola.


I've got the 3.5 version of the driver, and tried to find newer one. Where
do you get this new releases and patches?
Nevertheless thanks for the patch.

I also had some ssh problems, but AFAICR I had to enable UNIX98PTYS and
> BSDPTYS, and create the entries in /dev/ for the BSD ptys (/dev/ttypXX
> and /dev/ptyXX).


I also had these two options enabled, but still the kernel hangs at boot
time just after trying to initialize SCSI devices... Without Xenomai this
problem doesn't occur. I'm wondering what is that makes Xenomai mess up
things so badly?

Best regards,
Konstantin Boyanov

------=_Part_151991_16638288.1187855265285
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>Hi again,</div>
<div>&nbsp;</div>
<div>First of all thanks for reply.<br>&nbsp;</div>
<div>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">I attached a diff to the 3.7 version of the Motorola patch. I hope this<br>will help you. This is not the Xenomai version, but the standard version
<br>with VME interrupts per level. The mechanism for Xenomai is identical,<br>but I don&#39;t know yet about the legal status of this. The attached patch<br>has also been provided to Motorola.</blockquote>
<div>&nbsp;</div>
<div>I&#39;ve got the 3.5 version of the driver, and tried to find newer one. Where do you get this new releases and patches?</div>
<div>Nevertheless thanks for the patch.</div><br>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">I also had some ssh problems, but AFAICR I had to enable UNIX98PTYS and<br>BSDPTYS, and create the entries in /dev/ for the BSD ptys (/dev/ttypXX
<br>and /dev/ptyXX).</blockquote>
<div>&nbsp;</div>
<div>I also had these two options enabled, but still the kernel hangs at boot time just after trying to initialize SCSI devices... Without Xenomai this problem doesn&#39;t occur. I&#39;m wondering what is that makes Xenomai mess up things so badly?
</div>
<div>&nbsp;</div>
<div>Best regards,</div>
<div>Konstantin Boyanov</div></div>

------=_Part_151991_16638288.1187855265285--

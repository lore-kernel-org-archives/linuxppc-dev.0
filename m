Return-Path: <kkboyanov@gmail.com>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.227])
	by ozlabs.org (Postfix) with ESMTP id C6CB4DDE0F
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 21 Aug 2007 17:56:13 +1000 (EST)
Received: by wr-out-0506.google.com with SMTP id 71so1167538wri
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 21 Aug 2007 00:56:12 -0700 (PDT)
Message-ID: <929bf310708210056s2b699500x36c6b1ae83881496@mail.gmail.com>
Date: Tue, 21 Aug 2007 09:56:12 +0200
From: "Konstantin Boyanov" <kkboyanov@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Driver for device behind a PCI-VME bridge
In-Reply-To: <929bf310708210055k3970c3chfc097ff776af439a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_126588_29144553.1187682972554"
References: <929bf310708200140w6efc57f6k81a1339845059e2d@mail.gmail.com>
	<46C954AA.7050609@dutchspace.nl>
	<929bf310708200158m3dab7669j56e4dbf2d84f17a@mail.gmail.com>
	<929bf310708210055k3970c3chfc097ff776af439a@mail.gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_126588_29144553.1187682972554
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi again,

After some googling I came to the conclusion that the best approach to
understanding how to write a driver for a device behind a PCI-XXX bridge is
to look at the source for the USB subsystem, although the USB subsystem is
actually a bus subssytem and not a class.

Correct me if I'm wrong.

Regards,
Konstantin

------=_Part_126588_29144553.1187682972554
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<span class="gmail_quote"><br></span>
<div>Hi again,</div>
<div>&nbsp;</div>
<div>After some googling&nbsp;I came to the conclusion that the best approach to understanding how to write a driver for a device behind a PCI-XXX bridge is to look at the source for the USB subsystem, although the USB subsystem is actually a bus subssytem and not a class. 
</div>
<div>&nbsp;</div>
<div>Correct me if I&#39;m wrong.</div>
<div>&nbsp;</div>
<div>Regards,</div><span class="sg">
<div>Konstantin</div></span>

------=_Part_126588_29144553.1187682972554--

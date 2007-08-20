Return-Path: <kkboyanov@gmail.com>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.245])
	by ozlabs.org (Postfix) with ESMTP id C6868DDE42
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 20 Aug 2007 18:59:01 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c37so84258anc
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 20 Aug 2007 01:59:00 -0700 (PDT)
Message-ID: <929bf310708200158m3dab7669j56e4dbf2d84f17a@mail.gmail.com>
Date: Mon, 20 Aug 2007 10:58:59 +0200
From: "Konstantin Boyanov" <kkboyanov@gmail.com>
To: "Johan Borkhuis" <j.borkhuis@dutchspace.nl>
Subject: Re: Driver for device behind a PCI-VME bridge
In-Reply-To: <46C954AA.7050609@dutchspace.nl>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_113096_22940609.1187600339429"
References: <929bf310708200140w6efc57f6k81a1339845059e2d@mail.gmail.com>
	<46C954AA.7050609@dutchspace.nl>
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

------=_Part_113096_22940609.1187600339429
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Johan,

I already went through the user space stuff with the help of other people on
this list, but now I want to do reads and writes in kernel space, in other
words on driver level.
Main reason for the development of a driver for the device is interrupt
handling and signal sending to user space processes by the custom device in
short time frames (within miliseconds), e.g. proper and fast respond is
crutial. But for now I don't know how to do a simple read/write...

I'm using MVME6100 with ELinOS-based distro, kernel 2.6.15.

Regards,
Konstantin

------=_Part_113096_22940609.1187600339429
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Johan,<br><br>I already went through the user space stuff with the help of other people on this list, but now I want to do reads and writes in kernel space, in other words on driver level.<br>Main reason for the development of a driver for the device is interrupt handling and signal sending to user space processes by the custom device in short time frames (within miliseconds), 
e.g. proper and fast respond is crutial. But for now I don&#39;t know how to do a simple read/write...<br><br>I&#39;m using MVME6100 with ELinOS-based distro, kernel 2.6.15.<br><br>Regards,<br>Konstantin<br>

------=_Part_113096_22940609.1187600339429--

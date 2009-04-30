Return-Path: <ricardo.ribalda@gmail.com>
Received: from mail-fx0-f174.google.com (mail-fx0-f174.google.com
	[209.85.220.174]) by ozlabs.org (Postfix) with ESMTP id C0B70DDEEB
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Apr 2009 18:26:52 +1000 (EST)
Received: by fxm22 with SMTP id 22so1640182fxm.9
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Apr 2009 01:26:50 -0700 (PDT)
MIME-Version: 1.0
Sender: ricardo.ribalda@gmail.com
In-Reply-To: <D18D3A18-4388-4F0E-A688-BF375F9C7AB0@kernel.crashing.org>
References: <1240581715-25926-1-git-send-email-ricardo.ribalda@uam.es>
	<0F60D78C-63E2-4A8A-9EBE-80AAFB3B00A0@kernel.crashing.org>
	<aa76a2be0904290041m27d6309eu76d04d294ca9ba3d@mail.gmail.com>
	<D18D3A18-4388-4F0E-A688-BF375F9C7AB0@kernel.crashing.org>
From: Ricardo Ribalda Delgado <ricardo.ribalda@uam.es>
Date: Thu, 30 Apr 2009 10:26:30 +0200
Message-ID: <aa76a2be0904300126ife6b64cgf920971c65477060@mail.gmail.com>
Subject: Re: [PATCH] [MTD] ofpart: Partitions at same address cannot have
	thesame name v3
To: Segher Boessenkool <segher@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	David.Woodhouse@intel.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello

>
> Ah! =A0After writing my original reply, I read the documentation,
> and this had me confused.
>
> 4b08e14 looks wrong to me. =A0It also didn't update the documentation.


So, what shall we do, revert  4b08e14 or apply this patch changing the
name to "linux,mtd,partition" or similar.... ?

  Regards


--=20
Ricardo Ribalda
http://www.eps.uam.es/~rribalda/

Return-Path: <Alexander.Povolotsky@marconi.com>
Received: from mailgate.pit.comms.marconi.com (mailgate.pit.comms.marconi.com
	[169.144.68.6]) by ozlabs.org (Postfix) with ESMTP id 2FE8567A72
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 19 Jan 2005 02:48:05 +1100 (EST)
Message-ID: <313680C9A886D511A06000204840E1CF0A6474FF@whq-msgusr-02.pit.comms.marconi.com>
From: "Povolotsky, Alexander" <Alexander.Povolotsky@marconi.com>
To: "'Mark Chambers'" <markc@mail.com>
Date: Tue, 18 Jan 2005 10:45:53 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Cc: "'linuxppc-embedded@ozlabs.org'" <linuxppc-embedded@ozlabs.org>
Subject: RE: Linux 2.6-10.rc3  8xx: debugging (over-writing)  content of b
	d_in fo structure  in the kernel booting code
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Mark,

Forgot to mention - this board boots (and works) well with Linux 2.4.26 with
the
same bootloader structure 
and
same embed_config(bd_t **bdp) function (in
arch/ppc/boot/simple/embed_config.c))

as listed before

Regards,
Alex

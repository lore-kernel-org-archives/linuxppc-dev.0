Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
From: Jim Thompson <jim@SmallWorks.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15318.24383.143536.778353@zaphod.smallworks.com>
Date: Wed, 24 Oct 2001 01:27:11 -0500
To: wd@denx.de
Cc: sruel@oerlikon.ca, scott_anderson@mvista.com,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: RPX-CLLF & Flash root filesystem 
In-Reply-To: <20011023225510.6AE3510CD6@denx.denx.de>
References: <3BD5E62D.8000807@oerlikon.ca>
	<20011023225510.6AE3510CD6@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> With PPCBoot you pass the addresses of both images  as  arguments  to
> the "bootm" command.

Wolfgang,

Have you considered cramfs support for ppcboot?

Jim

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

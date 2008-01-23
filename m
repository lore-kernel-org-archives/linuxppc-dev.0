Return-Path: <roman.fietze@telemotive.de>
Received: from mail.telemotive.de (mail.telemotive.de [62.206.149.210])
	by ozlabs.org (Postfix) with ESMTP id ABDFADDE1F
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 23 Jan 2008 18:46:10 +1100 (EST)
Received: from rfietze.mit.telemotive.de (rfietze.mit.telemotive.de
	[192.168.5.33])
	by alderan.mit.telemotive.de (Postfix) with ESMTP id 90E4367A9C
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 23 Jan 2008 08:39:33 +0100 (CET)
From: Roman Fietze <roman.fietze@telemotive.de>
To: linuxppc-embedded@ozlabs.org
Subject: Re: framebuffer swap endianess
References: <323144.65236.qm@web23105.mail.ird.yahoo.com>
In-Reply-To: <323144.65236.qm@web23105.mail.ird.yahoo.com>
MIME-Version: 1.0
Message-ID: <200801230839.33212.roman.fietze@telemotive.de>
Date: Wed, 23 Jan 2008 08:39:33 +0100
Content-Type: text/plain;
  charset="iso-8859-15"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello ANgelo,

On Tuesday 22 January 2008 16:46:47 Angelo wrote:

> I have just create a framebuffer for an embedded system:
> - powerpc (little endian)  with  a GPU (big endian).

Are you sure? Isn't it the other way around?

> When i try to execute Xfbdev, it starts but with wrong colors.  I
> need to swap the RGB format (RRRRRGGGGGGBBBBB) to BGR, respecting
> the endianess (GGGRRRRRBBBBBGGG).

We modified the X Server and swapped when transferring from the shadow
buffer to the video buffer. That cured all our problems. This was on
the 2.4.25 from DENX and with Xfree86.

Other modifications like changing the RGB masks for the display/screen
only helped partwise, because some applications just ignored that when
using some image formats.


Roman

=2D-=20
Roman Fietze Telemotive AG B=FCro M=FChlhausen

Return-Path: <Alexander.Povolotsky@marconi.com>
Received: from mailgate.pit.comms.marconi.com (mailgate.pit.comms.marconi.com
	[169.144.68.6]) by ozlabs.org (Postfix) with ESMTP id EA80B67A2C
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 19 Jan 2005 05:57:25 +1100 (EST)
Message-ID: <313680C9A886D511A06000204840E1CF0A647501@whq-msgusr-02.pit.comms.marconi.com>
From: "Povolotsky, Alexander" <Alexander.Povolotsky@marconi.com>
To: "'John W. Linville'" <linville@tuxdriver.com>
Date: Tue, 18 Jan 2005 13:52:54 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Cc: 'Steven Blakeslee' <BlakesleeS@embeddedplanet.com>,
	"'linuxppc-embedded@ozlabs.org'" <linuxppc-embedded@ozlabs.org>
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

The "one, I am using" from my previous e-mail relates to 2.6.10-rc3
My processor is MPC880.
-----Original Message-----
From: Povolotsky, Alexander 
Sent: Tuesday, January 18, 2005 1:19 PM
To: 'John W. Linville'
Cc: 'Mark Chambers'; 'linuxppc-embedded@ozlabs.org'; 'Tom Rini'; 'Steven
Blakeslee'
Subject: RE: Linux 2.6.10-rc3 8xx: debugging (over-writing) content of b
d_in fo structure in the kernel booting code

>Aren't there still generic problems w/ 8xx and 2.6.x?

Allegedly - yes (with memory initialization) but ...
both Tom Rini and Steve Blakeslee were able to boot their 
RPXLite Variant of 8xx on 2.6.10-rc3 (the one I am using)

-----Original Message-----
From: John W. Linville [mailto:linville@tuxdriver.com]
Sent: Tuesday, January 18, 2005 1:11 PM
To: Povolotsky, Alexander
Cc: 'Mark Chambers'; 'linuxppc-embedded@ozlabs.org'
Subject: Re: Linux 2.6.10-rc3 8xx: debugging (over-writing) content of b
d_in fo structure in the kernel booting code


On Tue, Jan 18, 2005 at 10:45:53AM -0500, Povolotsky, Alexander wrote:

> Forgot to mention - this board boots (and works) well with Linux 2.4.26 

Aren't there still generic problems w/ 8xx and 2.6.x?
-- 
John W. Linville
linville@tuxdriver.com

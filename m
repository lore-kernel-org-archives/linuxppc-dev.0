Return-Path: <dlclark@chtech.com>
Received: from mail26e.sbc-webhosting.com (mail26e.sbc-webhosting.com
	[216.173.236.227]) by ozlabs.org (Postfix) with SMTP id 7BDE1DDE27
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 17 Feb 2007 03:39:11 +1100 (EST)
From: "David Clark" <dlclark@chtech.com>
To: <a.llano@usyscom.com>
Subject: RE: 16-bit PCMCIA resource allocation
Date: Fri, 16 Feb 2007 10:32:44 -0600
Message-ID: <001e01c751e8$17d81c50$0f01a8c0@longhorn>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <1171624587.27115.18.camel@usyscom-sw-server>
Cc: =?iso-8859-1?Q?'Miguel_=C1ngel_=C1lvarez_Cabanes'?= <ma.alvarez@ziv.es>,
	'Aitor Arzuaga' <a.arzuaga@usyscom.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Asier,

Do you get the following message or similar during boot (dmesg output)?

"cs: memory probe 0x80000000-0xfcffffff:"
"  excluding 0x80000000-0xfcffffff"

Note: in my dmesg output these where not on consecutive lines.

David Clark
Senior Software Engineer
C&H Technologies, Inc
Web: http:\\www.chtech.com
Phone: 512-733-2621
Fax: 512-733-2629
Email: dlclark@chtech.com
 

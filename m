Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (vervifontaine.sonytel.be
	[80.88.33.193]) by ozlabs.org (Postfix) with ESMTP id 9C692DDE11
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Dec 2007 23:23:31 +1100 (EST)
Date: Tue, 4 Dec 2007 13:23:26 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v2 2/2] [POWERPC] Use new machine_xxx_initcall hooks in
	platform code
In-Reply-To: <20071202061033.21193.64818.stgit@trillian.secretlab.ca>
Message-ID: <Pine.LNX.4.62.0712041320250.12181@pademelon.sonytel.be>
References: <20071202061028.21193.39309.stgit@trillian.secretlab.ca>
	<20071202061033.21193.64818.stgit@trillian.secretlab.ca>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-584337861-110698418-1196771006=:12181"
Cc: linuxppc-dev@ozlabs.org, olof@lixom.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---584337861-110698418-1196771006=:12181
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Sat, 1 Dec 2007, Grant Likely wrote:
> From: Grant Likely <grant.likely@secretlab.ca>
> 
> This patch makes the platform code use the new machine-specific initcall
> hooks.  This has the advantage of not needing to explicitly test
> machine_is() at the top of every initcall function.

You seem to have missed the PS3 *_initcall()s.
Probably because they test for firmware_has_feature(FW_FEATURE_PS3_LV1) instead
of machine_is(ps3).

With kind regards,
 
Geert Uytterhoeven
Software Architect

Sony Network and Software Technology Center Europe
The Corporate Village · Da Vincilaan 7-D1 · B-1935 Zaventem · Belgium
 
Phone:    +32 (0)2 700 8453	
Fax:      +32 (0)2 700 8622	
E-mail:   Geert.Uytterhoeven@sonycom.com	
Internet: http://www.sony-europe.com/
 	
Sony Network and Software Technology Center Europe	
A division of Sony Service Centre (Europe) N.V.	
Registered office: Technologielaan 7 · B-1840 Londerzeel · Belgium	
VAT BE 0413.825.160 · RPR Brussels	
Fortis Bank Zaventem · Swift GEBABEBB08A · IBAN BE39001382358619
---584337861-110698418-1196771006=:12181--

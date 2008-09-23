Return-Path: <halesh.sadashiv@ap.sony.com>
Received: from SG2EHSOBE002.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80]) by ozlabs.org (Postfix) with ESMTP id 3796EDDE08
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 23 Sep 2008 19:31:49 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Subject: RE: Regarding select() on PPC
Date: Tue, 23 Sep 2008 15:01:27 +0530
Message-ID: <7B7EF7F090B9804A830ACC82F2CDE95D56E2C5@insardxms01.ap.sony.com>
From: "Sadashiiv, Halesh" <halesh.sadashiv@ap.sony.com>
To: <benh@kernel.crashing.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>



>-----Original Message-----
>From: Benjamin Herrenschmidt [mailto:benh@kernel.crashing.org]
>Sent: Tuesday, September 23, 2008 2:38 PM
>To: Sadashiiv, Halesh
>Cc: Arnd Bergmann; linuxppc-embedded@ozlabs.org
>Subject: RE: Regarding select() on PPC
>
>On Tue, 2008-09-23 at 12:46 +0530, Sadashiiv, Halesh wrote:
>>
>> >-----Original Message-----
>> >From: Benjamin Herrenschmidt [mailto:benh@kernel.crashing.org]
>> >Sent: Tuesday, September 23, 2008 12:00 PM
>> >To: Arnd Bergmann
>> >Cc: linuxppc-embedded@ozlabs.org; Sadashiiv, Halesh
>> >Subject: Re: Regarding select() on PPC
>> >
>> >On Tue, 2008-09-23 at 08:01 +0200, Arnd Bergmann wrote:
>> >> No, sorry, I don't have a git history that I can search for that.
>> >> I have a strong guess that it would be the end of the last century
>> >> though, probably before 2.3.48, since the comment in there already
>> >> refers to legacy binaries.
>> >
>> >Yeah, I'm keen to rip it out.
>>
>> Means argument checking in ppc_select() can be removed??
>> Than shall I post patch to linuxppc-dev@ozlabs.org
>
>ppc_select can probably be removed alltogether and ppc32_select too
>

Ok, directly sys_select() can be called instead of wrappers.

>Ben.
>
>

Halesh


-------------------------------------------------------------------
This email is confidential and intended only for the use of the =
individual or entity named above and may contain information that is =
privileged. If you are not the intended recipient, you are notified that =
any dissemination, distribution or copying of this email is strictly =
prohibited. If you have received this email in error, please notify us =
immediately by return email or telephone and destroy the original =
message. - This mail is sent via Sony Asia Pacific Mail Gateway.
-------------------------------------------------------------------

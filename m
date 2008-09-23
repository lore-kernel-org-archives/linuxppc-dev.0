Return-Path: <halesh.sadashiv@ap.sony.com>
Received: from SG2EHSOBE004.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80]) by ozlabs.org (Postfix) with ESMTP id 330B4DDEE3
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 23 Sep 2008 15:01:15 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Subject: RE: Regarding select() on PPC
Date: Tue, 23 Sep 2008 10:31:05 +0530
Message-ID: <7B7EF7F090B9804A830ACC82F2CDE95D56E14C@insardxms01.ap.sony.com>
From: "Sadashiiv, Halesh" <halesh.sadashiv@ap.sony.com>
To: <benh@kernel.crashing.org>
Cc: linuxppc-embedded@ozlabs.org
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
>Sent: Tuesday, September 23, 2008 10:26 AM
>To: Sadashiiv, Halesh
>Cc: Josh Boyer; linuxppc-embedded@ozlabs.org
>Subject: RE: Regarding select() on PPC
>
>On Tue, 2008-09-23 at 10:20 +0530, Sadashiiv, Halesh wrote:
>> Hi,
>>
>> The below testcase requires to exit with setting errno as EINVAL, as
per
>> the man page.
>>
>> I tested this on ARM, I686, PPC64 it was fine, for the same on PPC32
it
>> used exit with errno set as EFAULT.
>>
>> On further investigation found there was some long obsolete code in
>> arch/powerpc/kernel/syscalls.c (function ppc_select()), which was
>> written in 2.2.0 kernel for PPC32 specific , which resulted in
EFAULT.
>>
>> This needs to be verified, I have proposed patch for PPC32, Please
check
>> the link
>> http://article.gmane.org/gmane.linux.kernel/735922
>>
>
>I'm trying to sort out how obsolete it actually is and see if we can
>remove the whole thing.
>

Ok...once you verified please let me know.


>Your patch should be submitted to the linuxppc-dev mailing list btw.
>

Will do that.

>Ben.
>
>

Thanks,
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

Return-Path: <fkan@amcc.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id D85DBB6F20
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 18 Aug 2009 02:35:23 +1000 (EST)
Received: from sdcmail01.amcc.com (sdcmail01.amcc.com [198.137.200.72])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "Messaging Gateway Appliance Demo Cert",
	Issuer "Messaging Gateway Appliance Demo Cert" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 5017DDDD0B
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Aug 2009 02:35:22 +1000 (EST)
Message-ID: <4A8986C1.3080505@amcc.com>
Date: Mon, 17 Aug 2009 09:35:13 -0700
From: Feng Kan <fkan@amcc.com>
MIME-Version: 1.0
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/1 v1] powerpc44x: Add Eiger AMCC (AppliedMicro)	PPC460SX
	evaluation board support.
References: <1250123927-29167-1-git-send-email-fkan@amcc.com>
	<20090817153456.GD8710@zod.rchland.ibm.com>
In-Reply-To: <20090817153456.GD8710@zod.rchland.ibm.com>
Content-Type: multipart/alternative;
	boundary="------------040502080507050106010705"
Cc: linuxppc-dev@ozlabs.org, Tai Tri Nguyen <ttnguyen@amcc.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------040502080507050106010705
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Please do, much appreciated.

Thanks
Feng Kan
AMCC Software

On 08/17/2009 08:34 AM, Josh Boyer wrote:
> On Wed, Aug 12, 2009 at 05:38:47PM -0700, Feng Kan wrote:
>    
>> This patch adds support for the AMCC (AppliedMicro) PPC460SX Eiger evaluation board.
>>
>> Signed-off-by: Tai Tri Nguyen<ttnguyen@amcc.com>
>> Acked-by: Feng Kan<fkan@amcc.com>
>> Acked-by: Tirumala Marri<tmarri@amcc.com>
>> ---
>> arch/powerpc/boot/dts/eiger.dts            |  421 ++++++++++
>> arch/powerpc/configs/44x/eiger_defconfig   | 1200 ++++++++++++++++++++++++++++
>> arch/powerpc/platforms/44x/Kconfig         |   12 +
>> arch/powerpc/platforms/44x/ppc44x_simple.c |    1 +
>> 4 files changed, 1634 insertions(+), 0 deletions(-)
>> create mode 100644 arch/powerpc/boot/dts/eiger.dts
>> create mode 100644 arch/powerpc/configs/44x/eiger_defconfig
>>      
>
> Thanks, this looks great.
>
> If you have no objections, I will commit an updated defconfig against the
> current kernel sources instead of the one attached.  Some of the options
> will move around a bit, but there should be no overall changes.
>
> josh
>    


--------------040502080507050106010705
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html; charset=ISO-8859-1"
 http-equiv="Content-Type">
  <title></title>
</head>
<body text="#000000" bgcolor="#ffffff">
Please do, much appreciated.<br>
<br>
Thanks<br>
Feng Kan<br>
AMCC Software<br>
<br>
On 08/17/2009 08:34 AM, Josh Boyer wrote:
<blockquote cite="mid:20090817153456.GD8710@zod.rchland.ibm.com"
 type="cite">
  <pre wrap="">On Wed, Aug 12, 2009 at 05:38:47PM -0700, Feng Kan wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">This patch adds support for the AMCC (AppliedMicro) PPC460SX Eiger evaluation board.

Signed-off-by: Tai Tri Nguyen <a class="moz-txt-link-rfc2396E" href="mailto:ttnguyen@amcc.com">&lt;ttnguyen@amcc.com&gt;</a>
Acked-by: Feng Kan <a class="moz-txt-link-rfc2396E" href="mailto:fkan@amcc.com">&lt;fkan@amcc.com&gt;</a>
Acked-by: Tirumala Marri <a class="moz-txt-link-rfc2396E" href="mailto:tmarri@amcc.com">&lt;tmarri@amcc.com&gt;</a>
---
arch/powerpc/boot/dts/eiger.dts            |  421 ++++++++++
arch/powerpc/configs/44x/eiger_defconfig   | 1200 ++++++++++++++++++++++++++++
arch/powerpc/platforms/44x/Kconfig         |   12 +
arch/powerpc/platforms/44x/ppc44x_simple.c |    1 +
4 files changed, 1634 insertions(+), 0 deletions(-)
create mode 100644 arch/powerpc/boot/dts/eiger.dts
create mode 100644 arch/powerpc/configs/44x/eiger_defconfig
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Thanks, this looks great.

If you have no objections, I will commit an updated defconfig against the
current kernel sources instead of the one attached.  Some of the options
will move around a bit, but there should be no overall changes.

josh
  </pre>
</blockquote>
<br>
</body>
</html>

--------------040502080507050106010705--

Return-Path: <rsarmah@apm.com>
Received: from exprod5og112.obsmtp.com (exprod5og112.obsmtp.com [64.18.0.24])
	by ozlabs.org (Postfix) with SMTP id 6C945B70B8
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Nov 2010 02:32:41 +1100 (EST)
Received: by mail-wy0-f182.google.com with SMTP id 19so2171903wyf.41
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Nov 2010 07:32:38 -0800 (PST)
From: Rupjyoti Sarmah <rsarmah@apm.com>
References: <201011261110.oAQBANZL012455@amcc.com>
	<20101126142342.E05A411D94F1@gemini.denx.de>
In-Reply-To: <20101126142342.E05A411D94F1@gemini.denx.de>
MIME-Version: 1.0
Date: Fri, 26 Nov 2010 21:02:36 +0530
Message-ID: <ade8814261339ab5028557ae3dc15c0b@mail.gmail.com>
Subject: RE: [PATCH v3] ppc44x:PHY fixup for USB on canyonlands board
To: Wolfgang Denk <wd@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Wolfgang,

>> This results in a mix of "amcc," and "apm," strings.
>> Are there any plans to unify this?
We can make all as apm, but right now I believe there is no plan to do so.

>>Earlier versions of the patch included a delay after the clrbits8()
>>call as well. Is it intentional that you dropped this now?
It is dropped intentionally.

Rest of your suggestions, I will modify and resubmit. Thanks.

Regards,
Rup

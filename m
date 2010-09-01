Return-Path: <pku.leo@gmail.com>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by ozlabs.org (Postfix) with ESMTP id 7C438B715A
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  1 Sep 2010 13:40:04 +1000 (EST)
Received: by fxm11 with SMTP id 11so4479025fxm.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 31 Aug 2010 20:40:01 -0700 (PDT)
MIME-Version: 1.0
Sender: pku.leo@gmail.com
In-Reply-To: <C038AA46-E821-49EF-8958-747953FF56A0@kernel.crashing.org>
References: <1276842263-4186-1-git-send-email-leoli@freescale.com>
	<C038AA46-E821-49EF-8958-747953FF56A0@kernel.crashing.org>
Date: Wed, 1 Sep 2010 11:40:01 +0800
Message-ID: <AANLkTikcfOQOEK=-oV2DBN7et9jkHM5s-v08EWHBjKno@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] fsl_rio: fix compile errors
From: Li Yang <leoli@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Sep 1, 2010 at 5:39 AM, Kumar Gala <galak@kernel.crashing.org> wrot=
e:
>
> On Jun 18, 2010, at 1:24 AM, Li Yang wrote:
>
>> Fixes the following compile problem on E500 platforms:
>> arch/powerpc/sysdev/fsl_rio.c: In function 'fsl_rio_mcheck_exception':
>> arch/powerpc/sysdev/fsl_rio.c:248: error: 'MCSR_MASK' undeclared (first =
use in this function)
>>
>> Also fixes the compile problem on non-E500 platforms.
>>
>> Signed-off-by: Li Yang <leoli@freescale.com>
>> ---
>> arch/powerpc/sysdev/fsl_rio.c | =C2=A0 =C2=A06 +++++-
>> 1 files changed, 5 insertions(+), 1 deletions(-)
>
> applied to merge

Thanks, Kumar.

How about the other ones in the series?

- Leo

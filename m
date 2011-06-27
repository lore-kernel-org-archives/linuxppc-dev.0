Return-Path: <dbaryshkov@gmail.com>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8537AB6F90
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 28 Jun 2011 00:07:54 +1000 (EST)
Received: by vws20 with SMTP id 20so3773903vws.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 27 Jun 2011 07:07:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1308315107-29182-1-git-send-email-dbaryshkov@gmail.com>
References: <1308315107-29182-1-git-send-email-dbaryshkov@gmail.com>
Date: Mon, 27 Jun 2011 18:07:50 +0400
Message-ID: <BANLkTinFWxJM1LYXxkRv40ThZsa++bPVjg@mail.gmail.com>
Subject: Re: [PATCH V3 0/2] Improve CPC925 EDAC handling code on Maple
From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

On 6/17/11, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com> wrote:
> Hello, colleagues,
>
> Another respin of this patchset.
>
> Changes since previous version:
> * Fix comments in cpc925_edac.c
> * Rename cpc925_cpu_getmask() to cpc925_cpu_mask_disabled()
> * Don't return an error from init code if it's a U3 and not U3H
>
>  arch/powerpc/platforms/maple/setup.c |   41 +++++++++------------
>  drivers/edac/cpc925_edac.c           |   67
> +++++++++++++++++++++++++++++++++--
>  2 files changed, 83 insertions(+), 25 deletions(-)

Any chance to get this version reviewed/merged? Sorry for being noisy.

-- 
With best wishes
Dmitry

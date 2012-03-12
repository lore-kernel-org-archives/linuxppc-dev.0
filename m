Return-Path: <martyn.welch@ge.com>
Received: from exprod5og109.obsmtp.com (exprod5og109.obsmtp.com [64.18.0.188])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 8FB56B7062
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Mar 2012 04:16:42 +1100 (EST)
Message-ID: <4F5E2F73.2000703@ge.com>
Date: Mon, 12 Mar 2012 17:16:35 +0000
From: Martyn Welch <martyn.welch@ge.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V2 0/2] powerpc: Add support for GE IMP3A
References: <1331572380-1064-1-git-send-email-martyn.welch@ge.com>
In-Reply-To: <1331572380-1064-1-git-send-email-martyn.welch@ge.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Wim Van Sebroeck <wim@iguana.be>, Linus Walleij <linus.walleij@linaro.org>,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Whoops, forgot to correct the subject. This is v3 of the patches. I got it
right in the actual patches, just the cover letter I missed.

Martyn

On 12/03/12 17:12, Martyn Welch wrote:
> These patches add support for the GE IMP3A. This board (based on a Freescale
> P2020) uses some support for FPGA logic common with the PPC9A and other 86xx
> based boards, so this support has been moved out of the 86xx directory. A
> config option (GE_FPGA) has been added to reduce churn on dependant drivers
> (such as the watchdog timer) when further boards are added.

-- 
Martyn Welch (Lead Software Engineer)  | Registered in England and Wales
GE Intelligent Platforms               | (3828642) at 100 Barbirolli Square
T +44(0)1327322748                     | Manchester, M2 3AB
E martyn.welch@ge.com                  | VAT:GB 927559189

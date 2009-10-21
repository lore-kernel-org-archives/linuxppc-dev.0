Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 3DB1DB7B76
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Oct 2009 04:50:16 +1100 (EST)
To: Vivek Mahajan <vivek.mahajan@freescale.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: [PATCH v3 2/3] powerpc/fsl: 85xx: document cache-sram
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <1256129459-10685-2-git-send-email-vivek.mahajan@freescale.com>
References: <1256129459-10685-1-git-send-email-vivek.mahajan@freescale.com>
	<1256129459-10685-2-git-send-email-vivek.mahajan@freescale.com>
Date: Wed, 21 Oct 2009 19:50:12 +0200
Message-Id: <20091021175012.ED29819F73@gemini.denx.de>
Cc: linuxppc-dev@ozlabs.org, kumar.gala@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dear Vivek Mahajan,

In message <1256129459-10685-2-git-send-email-vivek.mahajan@freescale.com> you wrote:
> Adds documentation for Freescale's QorIQ based cache-sram as under:-
> 
> * How to enable it from a low level driver
> * How to set its size
...
> +The size of the above cache SRAM memory window is passed via the
> +kernel command line as <cache-sram-size=....>

Would it not make more sense to configure this property through the
device tree? 

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
"Don't worry about people stealing your ideas. If your ideas are  any
good, you'll have to ram them down people's throats."  - Howard Aiken

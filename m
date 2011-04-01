Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id C25F9B6F86
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  2 Apr 2011 07:06:56 +1100 (EST)
To: tmarri@apm.com
From: Wolfgang Denk <wd@denx.de>
Subject: Re: [PATCH v11 03/10] USB/ppc4xx: Add Synopsys DWC OTG Core Interface
	Layer (CIL)
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <1301684711-17386-1-git-send-email-tmarri@apm.com>
References: <1301684711-17386-1-git-send-email-tmarri@apm.com>
Date: Fri, 01 Apr 2011 22:00:38 +0200
Message-Id: <20110401200038.BF323142E074@gemini.denx.de>
Cc: greg@kroah.com, linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dear tmarri@apm.com,

In message <1301684711-17386-1-git-send-email-tmarri@apm.com> you wrote:
> From: Tirumala Marri <tmarri@apm.com>
> 
> Core Interface Layer Common provides common functions for both host
> controller and peripheral controller.  CIL manages the memory map
> for the core. It also handles basic tasks like reading/writing the
> registers and data FIFOs in the controller. CIL performs basic
> services that are not specific to either the host or device modes
> of operation. These services include management of the OTG Host
> Negotiation Protocol (HNP) and Session Request Protocol (SRP).
> ---

Signed-off-by: line missing.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
"No problem is so formidable that you can't walk away from it."
- C. Schulz

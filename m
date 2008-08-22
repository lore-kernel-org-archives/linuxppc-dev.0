Return-Path: <jwboyer@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.180])
	by ozlabs.org (Postfix) with ESMTP id 8E13EDE0F9
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 22 Aug 2008 23:30:48 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id a29so299620pyi.27
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 22 Aug 2008 06:30:46 -0700 (PDT)
Date: Fri, 22 Aug 2008 09:30:20 -0400
From: Josh Boyer <jwboyer@gmail.com>
To: fkan@amcc.com
Subject: Re: [PATCH] AMCC PPC460GT/EX PCI-E de-emphasis adjustment fix
Message-ID: <20080822133020.GE22283@yoda.jdub.homelinux.org>
References: <1219380814-17229-1-git-send-email-fkan@amcc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1219380814-17229-1-git-send-email-fkan@amcc.com>
Cc: sr@denx.de, Tirumala R Marri <tmarri@amcc.com>,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Aug 21, 2008 at 09:53:34PM -0700, fkan@amcc.com wrote:
>From: Tirumala R Marri <tmarri@amcc.com>
>
>During recent tests with PCI-E , it has been found the
>DRV + De-Emphasis values are not optimum. These new values
>are tested thouroughly.
>
>Signed-off-by: Tirumala R Marri <tmarri@amcc.com>

If you are sending out a patch for someone, you need to include your
Signed-off-by as well.  Just reply to this with it, no need to resend
the just for this.

Stefan, this looks good to me.  Or at least as far as I can tell from
the somewhat magic values :)  Any comments?

josh

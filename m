Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.240])
	by ozlabs.org (Postfix) with ESMTP id 1A9EFDEF74
	for <linuxppc-dev@ozlabs.org>; Sat, 17 May 2008 05:42:40 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c34so305143anc.78
	for <linuxppc-dev@ozlabs.org>; Fri, 16 May 2008 12:42:39 -0700 (PDT)
Message-ID: <fa686aa40805161242g4295da76sdbebbc1009f041e4@mail.gmail.com>
Date: Fri, 16 May 2008 13:42:39 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: linuxppc-dev@ozlabs.org, spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, dbrownell@users.sourceforge.net
Subject: Re: [PATCH 4/4] [CSB] Add new mpc5200-spi (non-psc) device driver
In-Reply-To: <20080516193618.28030.15219.stgit@trillian.secretlab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080516193054.28030.35126.stgit@trillian.secretlab.ca>
	<20080516193618.28030.15219.stgit@trillian.secretlab.ca>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, May 16, 2008 at 1:36 PM, Grant Likely <grant.likely@secretlab.ca> wrote:
> From: Grant Likely <grant.likely@secretlab.ca>
>
> Unlike the old CSB driver, this driver uses the SPI infrastructure.

er, this comment is *obviously* wrong.  I'll fix it in the next version.

Cheers,
g.


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
